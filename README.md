# REACTOR
This is an R package for statistical analysis of regulons. This package expects the outputs of the SCENIC framework and clustering information as its inputs. The package uses ROTS R package for conducting the statistical testing and this in turn makes it possible to conduct the analysis on data of various experimental conditions, including case-control- and multigroup analysis. REACTOR outputs the resulting ROTS object as well as a dataframe of the results for users with no experience using ROTS.


#### Installation
``` R 
install.packages("devtools")
devtools::install_github("elolab/REACTOR")

```

Or from source (in your shell)
```
git clone THISPAGE
R -e 'install.packages("devtools"); devtools::install("REACTOR")'
```


#### USAGE

Please see the vignette for an example analysis.




