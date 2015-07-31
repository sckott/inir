file_ext <- function(x) {
  gsub("\\.", "", strextract(x, "\\.[A-Za-z0-9]+$"))
}

strextract <- function(str, pattern) regmatches(str, regexpr(pattern, str))
