\name{differentialActivityAnalysis}
\alias{differentialActivityAnalysis}
\title{Perform differential activity analysis using ROTS}
\description{Using proportional counts of binary regulon activity, performs ROTS analysis to detect differentially expressed
regulons.}
\usage{
differentialActivityAnalysis(data, groups, maxZeros = NA, \dots)
}
\arguments{
  \item{data}{Data frame contating the proportional counts of binary regulon activity. This is the first output produced by the REACTOR::processData-function.}
  \item{groups}{Vector indicating the sample groups, i.e. c(1,1,1,2,2,2)}
  \item{maxZeros}{Maximum number of zero values present in a row of the input data frame. Rows that contain more zero values than this parameter will be filtered before the ROTS analysis.}
  \item{\dots}{Parameters to passed into ROTS, such as seed and B. See \code{\link[ROTS]{ROTS}}}}
}
\value{
  Function returns a list containing the ROTS object as well as a simplified results matrix
}
