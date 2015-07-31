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
file1 <- system.file("examples", "example2.ini", package = "inir")
ini_parse(file1)
#> $example2.ini
#> <<ini config file>> example2.ini
#>   sections (length): 
#>     General: 1
#>     Profile0: 3
```

## Parse > 1 file


```r
file2 <- system.file("examples", "example1.ini", package = "inir")
ini_parse(c(file1, file2))
#> $example2.ini
#> <<ini config file>> example2.ini
#>   sections (length): 
#>     General: 1
#>     Profile0: 3
#> 
#> $example1.ini
#> <<ini config file>> example1.ini
#>   sections (length): 
#>     mediabrowsergroup: 3
#>     mediabrowsercontentsgroup: 5
#>     contentgroup: 3
#>     mtgetmediapopout: 1
#>     mtgatherandplaypopout: 1
#>     mtmydevicespopout: 1
#>     mtsearchpopout: 1
#>     nowplaying_popout: 1
#>     lid_v_mediabrowser_contents: 4
#>     videowindow: 3
#>     contextwindow: 4
#>     presentationwindow_norestore: 5
#>     mediabrowser_popout: 1
#>     mainapplicationwindow: 4
```

## Meta

* License: MIT
* Get citation information for `inir` in R doing `citation(package = 'inir')`
