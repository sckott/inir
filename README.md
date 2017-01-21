inir
=====



[![Build Status](https://api.travis-ci.org/sckott/inir.png?branch=master)](https://travis-ci.org/sckott/inir)
[![codecov.io](http://codecov.io/github/sckott/inir/coverage.svg?branch=master)](http://codecov.io/github/sckott/inir?branch=master)

`inir` is a `.ini`/`.cfg` file parser

About `.ini`/`.cfg` files: [the INI file Wikipedia page](https://en.wikipedia.org/wiki/INI_file)

## Installation


```r
install.packages("devtools")
devtools::install_github("sckott/inir")
```


```r
library("inir")
```

## Parse a file

Get a file


```r
gitfile <- system.file("examples", "gitconfig.ini", package = "inir")
```

instantiate new object with file path


```r
(res <- ini(gitfile))
#> <<ini config file>> gitconfig.ini.
```

get file path


```r
res$file
#> [1] "/Library/Frameworks/R.framework/Versions/3.3/Resources/library/inir/examples/gitconfig.ini"
```

read file


```r
res$read()
#> $gitconfig.ini
#> <<ini config file>> gitconfig.ini
#>   sections (length): 
#>     core: 6
#>     remote "origin": 2
#>     branch "master": 2
#>     travis: 1
```

get section names


```r
res$sections()
#> [1] "core"              "remote \"origin\"" "branch \"master\""
#> [4] "travis"
```

get contents of a single section


```r
res$get("core")
#> $repositoryformatversion
#> [1] "0"
#> 
#> $filemode
#> [1] "true"
#> 
#> $bare
#> [1] "false"
#> 
#> $logallrefupdates
#> [1] "true"
#> 
#> $ignorecase
#> [1] "true"
#> 
#> $precomposeunicode
#> [1] "true"
```

## Meta

* License: MIT
* Get citation information for `inir` in R doing `citation(package = 'inir')`
* Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
