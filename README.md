inir
=====



[![Build Status](https://api.travis-ci.org/sckott/inir.png?branch=master)](https://travis-ci.org/sckott/inir)

`inir` is a `.ini`/`.cfg` file parser

## Installation


```r
install.packages("devtools")
devtools::install_github("sckott/inir")
```


```r
library("inir")
```

## Parse a single file


```r
file1 <- system.file("examples", "example1.ini", package = "inr")
ini_parse(file1)
#> $example1.ini
#> $example1.ini$mediabrowsergroup
#> $example1.ini$mediabrowsergroup$title
#> [1] "mediabrowsergroup"
#> 
#> $example1.ini$mediabrowsergroup$pairs
#> $example1.ini$mediabrowsergroup$pairs[[1]]
#> $example1.ini$mediabrowsergroup$pairs[[1]]$key
#> [1] "navigationaction"
#> 
...
```

## Parse > 1 file


```r
file2 <- system.file("examples", "example2.ini", package = "inr")
ini_parse(c(file1, file2))
#> $example1.ini
#> $example1.ini$mediabrowsergroup
#> $example1.ini$mediabrowsergroup$title
#> [1] "mediabrowsergroup"
#> 
#> $example1.ini$mediabrowsergroup$pairs
#> $example1.ini$mediabrowsergroup$pairs[[1]]
#> $example1.ini$mediabrowsergroup$pairs[[1]]$key
#> [1] "navigationaction"
#> 
...
```

## Meta

* License: MIT
* Get citation information for `inir` in R doing `citation(package = 'inir')`
