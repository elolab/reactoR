performDETesting <-
function(data, groups, B=100, K=5000, seed=1234, maxZeros = NA){
  
  if(is.na(maxZeros)){
    maxZeros <- ncol(data)
  }

  #Gather rows with enough non NA values and filter the rest
  cases_2_remain <- rowSums(!is.na(data[groups==unique(groups)[1], ])) >= 2
  controls_2_remain <- rowSums(!is.na(data[groups==unique(groups)[2],])) >= 2
  data_filtered <- data
  data_filtered <- data_filtered[cases_2_remain & controls_2_remain,]
  
  #Change the datatypes of the columns in the data frame and rename back to original
  data_filtered <- as.data.frame(lapply(data_filtered,as.numeric))
  rownames(data_filtered) <- rownames(data[cases_2_remain & controls_2_remain,])
  
  #Filter rows based on zero values
  data_filtered <- subset(data_filtered , rowSums(data_filtered  == 0) <= maxZeros)
  
  #Run ROTS
  ROTS_object = ROTS(data = data_filtered, groups = groups , B = B , K = K , seed = seed)
  
  results_rots <- cbind(ROTS_object$data, data.frame(d=ROTS_object$d, p=ROTS_object$pvalue, fdr=ROTS_object$FDR, fc = ROTS_object$logfc))
  results_rots <- arrange(results_rots, fdr)
  
  return(list(ROTS_object, results_rots))
}
