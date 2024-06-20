\name{performDETesting}
\alias{performDETesting}
\title{Perform DEA using ROTS on the regulon}
\description{Using proportional counts of binary regulon activity, performs ROTS analysis to detect differentially expressed
regulons.}
\usage{
performDETesting(data, groups, B, K, seed, maxZeros = NA)
}
\arguments{
  \item{data}{Data frame contating the proportional counts of binary regulon activity}
  \item{groups}{Vector indicating the sample groups}
  \item{B}{Number of bootstrap- and permutation resamplings used in ROTS analysis}
  \item{K}{Integer indicating the largest top list size considered in the ROTS analysis}
  \item{seed}{Seed used in ROTS analysis}
  \item{maxZeros}{Maximum number of zero values present in a row of the input data frame. Rows that contain more zero values than this parameter will be filtered before the ROTS analysis.}
}
\value{
  Function returns a list containing the ROTS object as well as a simplified results matrix
}