\name{processData}
\alias{processData}
\title{Process the input files for ROTS analysis}
\description{Process the inputs from SCENIC and SEURAT by combining their information and transforming the dataframes into a format that ROTS can process}
\usage{
processData(minCells = 0,
  RBM,
  StudyDesign,
  Clustering,
  cluster_cName,
  condition_cName,
  sample_cName)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{minCells}{
  Parameter for filtering the data based on the minimum number of cells present in a cell-type cluster within a donor
}
  \item{RBM}{
  Regulon Binary Matrix. The output produced by the SCENICs binarize-function works here. Please also make sure that the first column represents the single cell sample IDs!
  }
  \item{StudyDesign}{
  Study design dataframe. Should contain information (as columns) from which sample and which condition the single cell sample came from. Please also make sure that the first column represents the single cell sample IDs!
  }
  \item{Clustering}{
  scRNA clustering results as a dataframe. Please also make sure that the first column represents the single cell sample IDs!
  }
  \item{cluster_cName}{
  Name of the column you wish to use as your clusters from the Clustering dataframe.
  }
  \item{condition_cName}{
  Name of the column of conditions to be contrasted from the StudyDesign dataframe (i.e COVID or Healthy).
  }
  \item{sample_cName}{
  Name of the sample column from the StudyDesign dataframe.
  }
}
\value{
  Function returns a list containing the proportional counts of binary regulon activity in a format processable by ROTS as well as the regulonActivity table.
}