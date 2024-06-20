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
  Regulon Binary Matrix
  }
  \item{StudyDesign}{
  Study design dataframe
  }
  \item{Clustering}{
  scRNA clustering results
  }
  \item{cluster_cName}{
  Name of the column for clustering results
  }
  \item{condition_cName}{
  Name of the column of conditions to be contrasted
  }
  \item{sample_cName}{
  Name of the sample name column
  }
}
\value{
  Function returns a list containing the proportional counts of binary regulon activity in a format processable by ROTS as well as the regulonActivity table
}