library(tidyverse)
library(REACTOR)
path="/home/markus/Seafile/B23017_SCENIC_application/DREa/input/blish/"
rbm_fname           = paste0(path,"auc_binary.csv")
study_fname         = paste0(path,"metadata.csv")
cluster_fname       = paste0(path,"clustering.csv")

# Read Data
rbm <- read_csv(rbm_fname)
studyDesign <- read_csv(study_fname)
clustering <- read_csv(cluster_fname)


sample_cname      = "Donor" # Set this to "Donor.full" if you want to include donor C1B and C1A as separate entities. Now using their average value
cluster_cname     = "cell.type"
condition_cname   = "Status"

minCells = 10
maxZeros = 3

# processData returns a list that contains the processed data at index 1 and
# RegulonActivity dataframe at index 2. The regulonActivity dataframe can be
# viewed to fine tune the minCells parameter for future runs.
data_out <- REACTOR::processData(minCells = minCells, RBM = rbm, 
                StudyDesign = studyDesign, Clustering = clustering, 
                condition_cName = condition_cname, sample_cName = sample_cname,
                cluster_cName = cluster_cname)

long_data <- data_out[[1]]
regulonActivity <- data_out[[2]]

groups <- c(rep(1,7), rep(2,6)) # Change the 7 to 8 if you want to analyze donors C1A and B separately
DE_out <- REACTOR::performDETesting(long_data, groups, maxZeros = maxZeros)
ROTS_obj <- DE_out[[1]]
rots_out <- DE_out[[2]]

pdf(file="volcano.pdf")
        plot(ROTS_obj, type="volcano")
dev.off()

rots_filtered <- rots_out[rots_out$fdr <= 0.05,]
rots_p_filtered <- rots_out[rots_out$p <= 0.05,]

mean_covid <- apply(rots_filtered[,1:7],1,mean)
mean_healthy <- apply(rots_filtered[,8:13],1,mean)
mean_data <- apply(rots_filtered[,1:13],1,mean)
signed_mean <- as.vector(ifelse(mean_covid >= mean_healthy, 1, -1)) * mean_data
rots_filtered$signedmean <- signed_mean
rots_filtered <- arrange(rots_filtered, signedmean)
rots_filtered <- rots_filtered[, -which(names(rots_filtered) == "signedmean")]

boxplot_data <- t(rots_filtered[,1:13])
condition <- data.frame(condition <- c(rep("COVID", 7), rep("Healthy", 6)))
colnames(condition) <- "condition"
boxplot_data <- cbind(condition, boxplot_data)

pdf(file="vboxplot.pdf")
par(mgp = c(1.5,0.5,0), mar = c(8.1, 2.5, 1.1, 1.1))
boxplot(boxplot_data[,-1], boxfill = NA, border = NA, ylim = c(0,100), cex.axis=0.65, yaxt="n", las=2, ylab = "Activity") #invisible boxes - only axes and plot area


boxplot(boxplot_data[boxplot_data$condition=="COVID", -1], xaxt = "n", add = TRUE, boxfill="tomato",
         outline = F, boxwex=0.25, at = 1:ncol(boxplot_data[,-1]) - 0.15) #shift these left by -0.15

boxplot(boxplot_data[boxplot_data$condition=="Healthy", -1], xaxt = "n", add = TRUE, boxfill="dodgerblue",
        outline = F, boxwex=0.25, at = 1:ncol(boxplot_data[,-1]) + 0.15) #shift these left by -0.15

legend("top",2, 4, legend=c("COVID", "Healthy"),  
       fill = c("tomato","dodgerblue") )

colnames(boxplot_data)
dev.off()
