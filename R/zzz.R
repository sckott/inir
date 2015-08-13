file_ext <- function(x) {
  gsub("\\.", "", strextract(x, "\\.[A-Za-z0-9]+$"))
}

strextract <- function(str, pattern) regmatches(str, regexpr(pattern, str))

strtrim <- function(str) gsub("^\\s+|\\s+$", "", str)

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

  res <- sapply(sets, function(z) {
    title <- gsub("\\[|\\]", "", z[[1]])
    pairs <- z[-1]
    # remove empty pairs
    pairs <- Filter(function(x) nchar(x) > 0, pairs)
    # parse pairs to key-values
    #     pairs <- lapply(pairs, function(w) {
    #       as.list(setNames(strsplit(w, "=|:")[[1]], c('key', 'value')))
    #     })
    pairs <- sapply(pairs, function(w) {
      ## FIXME - need to split just on first occurrence of = or :
      tmp <- strsplit(w, "=|:")[[1]]
      tmp <- strtrim(tmp)
      if (length(tmp) > 1) {
        tmp[2] <- paste0(tmp[-1], collapse = ":")
      }
      as.list(setNames(tmp[2], tmp[1]))
    }, USE.NAMES = FALSE)
    setNames(list(pairs), title)
  })

  # hh <- setNames(res, vapply(res, "[[", "", "title"))
  attr(res, "file_name") <- fname
  res
}

#' @export
print.ini <- function(x, ...) {
  cat(paste0("<<ini config file>> ", attr(x, "file_name")), sep = "\n")
  cat("  sections (length): ", sep = "\n")
  for (i in seq_along(x)) {
    cat(sprintf("    %s: %s", names(x[i]), length(x[[i]])), sep = "\n")
  }
}

ini_write <- function(x, path) {
  for (i in seq_along(x)) {
    # section header
    cat(sprintf("[%s]", names(x)[i]), file = path, append = TRUE)
    # keys
    for (j in seq_along(x[[i]])) {
      kv <- x[[i]][j]
      cat(sprintf("\n  %s = %s", names(kv), kv[1]), file = path, append = TRUE)
    }
    cat("\n", file = path, append = TRUE)
  }
}
