processData <-
function(minCells = 0, RBM, StudyDesign, Clustering, cluster_cName, condition_cName,
                     sample_cName = NULL) {
  

  #Rename data columns for readability
  RBM <- rename(RBM, CellID = 1)
  Clustering <- rename(Clustering, CellID = 1)
  StudyDesign <- rename(StudyDesign, CellID = 1)
  Clustering <- rename(Clustering, Cluster = cluster_cName)
  StudyDesign <- rename(StudyDesign, Condition = condition_cName)
  StudyDesign <- rename(StudyDesign, Group = sample_cName)
  
  
  #Join the data tables
  RegulonActivity <- RBM %>% 
    left_join(Clustering) %>% 
    left_join(StudyDesign) %>% 
    group_by(Cluster, Group, Condition) %>%
    summarise(Cells = n(), across(where(is.numeric), sum)) %>%
    filter(Cells >= minCells) %>% 
    mutate(across(where(is.numeric) & !c(Cells), function(x) x*100/Cells))
  
  #Remove rows with no donor information
  RegulonActivity <- RegulonActivity[!is.na(RegulonActivity$Group),]
  
  #Get all the cluster names and regulon names for looping through them
  all_regulons  <- names(RegulonActivity)[sapply(RegulonActivity, is.double)]
  all_clusters  <- unique(RegulonActivity$Cluster)
  
  # Initialize the output DF
  long_data <- data.frame()
  
  
  #Loop through all the clusters and regulons and bind the results to the output DF
  for (i in 1:length(all_clusters)){
    for (j in 1:length(all_regulons)){
      
      regulon_cluster <- RegulonActivity %>% ungroup() %>% select(c(Cluster,Group,Condition,all_regulons[j]))
      regulon_cluster <- filter(regulon_cluster, Cluster == all_clusters[i] )
      
      #Prepare the rowdata to be inserted into the final dataframe
      rowName <- paste0(all_clusters[i], " | ", all_regulons[j])
      rowData <- data.frame(matrix(ncol = length(unique(RegulonActivity$Group)), nrow = 0))
      colnames(rowData) <- unique(RegulonActivity$Group)
      temp_row <- t(regulon_cluster[,c(2,4)])
      colnames(temp_row) <- as.vector(temp_row[1,])
      temp_col_names <- colnames(temp_row)
      temp_row <- t(as.data.frame(temp_row[-1, ] ))
      colnames(temp_row) <- temp_col_names
      rowData[1, colnames(temp_row)] <- temp_row
      rownames(rowData) <- rowName
      
      long_data <- rbind(long_data, rowData)
      
      
      
    }
  }
  
  return(list(long_data, RegulonActivity))
  
  
}
