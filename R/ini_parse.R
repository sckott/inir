#' Parse a .ini or a .cfg file
#'
#' @export
#' @param x File paths, one or more
#' @examples \dontrun{
#' file1 <- system.file("examples", "example1.ini", package="inir")
#' ini_parse(file1)
#'
#' file2 <- system.file("examples", "example2.ini", package="inir")
#' ini_parse(c(file1, file2))
#' }
ini_parse <- function(x) {
  file_exists(x)
  check_file_ext(x)
  fnames <- basename(x)
  files_parse(x, fnames)
}

file_exists <- function(x) {
  fex <- file.exists(x)
  if (!all(fex)) {
    stop("These files do not exist \n", paste0(x[!fex], collapse = "\n"), call. = FALSE)
  }
}

check_file_ext <- function(x) {
  exts <- unname(vapply(x, file_ext, ""))
  exts_bool <- exts %in% c("ini", "cfg")
  if (!all(exts_bool)) {
    stop("You sure this is a INI file?", call. = FALSE)
  }
}

files_parse <- function(x, y) {
  out <- setNames(Map(file_parse, x, y), y)
  lapply(out, structure, class = "ini")
}

file_parse <- function(z, fname) {
  txt <- readLines(z)
  starts <- grep("\\[", txt)

  sets <- list()
  for (i in seq_along(starts)) {
    if (i == length(starts)) {
      end <- length(txt)
    } else {
      end <- starts[i + 1] - 1
    }
    sets[[i]] <- txt[starts[i]:end]
  }

  res <- lapply(sets, function(z) {
    title <- gsub("\\[|\\]", "", z[[1]])
    pairs <- z[-1]
    # remove empty pairs
    pairs <- Filter(function(x) nchar(x) > 0, pairs)
    # parse pairs to key-values
    pairs <- lapply(pairs, function(w) {
      as.list(setNames(strsplit(w, "=|:")[[1]], c('key', 'value')))
    })
    list(title = title, pairs = pairs)
  })

  hh <- setNames(res, vapply(res, "[[", "", "title"))
  attr(hh, "file_name") <- fname
  hh
}

#' @export
print.ini <- function(x, ...) {
  cat(paste0("<<ini config file>> ", attr(x, "file_name")), sep = "\n")
  cat("  sections (length): ", sep = "\n")
  for (i in seq_along(x)) {
    cat(sprintf("    %s: %s", names(x[i]), length(x[[i]]$pairs)), sep = "\n")
  }
}
