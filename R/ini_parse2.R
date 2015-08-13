#' Parse a .ini or a .cfg file
#'
#' @export
#' @import R6
#' @param x File paths, one or more
#' @examples \dontrun{
#' # example file
#' gitfile <- system.file("examples", "gitconfig.ini", package = "inir")
#'
#' # instantiate new object with file path
#' (res <- Ini$new(file = gitfile))
#'
#' # get file path
#' res$file
#'
#' # read file
#' res$read()
#'
#' # get section names
#' res$sections()
#'
#' # get contents of a single section
#' res$get("core")
#' ## or index to it via the "parsed" element
#' res$parsed$gitconfig.ini[['core']]
#'
#' # another example getting a section
#' res$get('remote "origin"')
#' res$parsed$gitconfig.ini[['remote "origin"']]
#'
#' # You can set a default value with the get() method
#' res$get("stuff") # returns NULL
#' res$get("stuff", "hello_world") # default value
#'
#' # write file
#' res$write(path = "myfile2.ini")
#' }
Ini <- R6::R6Class("Ini",
   portable = FALSE,
   public = list(
     file = NA,
     parsed = NA,
     initialize = function(file) {
       self$file <- file
     },
     read = function() {
       self$parsed <- ini_parse(self$file)
       self$parsed
     },
     print = function() {
       cat(paste0("<<ini config file>> ", basename(self$file), ".\n"))
     },
     sections = function() {
       names(self$parsed[[1]])
     },
     get = function(x, fallback) {
       tmp <- self$parsed[[1]][[x]]
       if (is.null(tmp)) {
         if (missing(fallback)) NULL else fallback
       } else {
         tmp
       }
     },
     write = function(path) {
       ini_write(self$parsed[[1]], path)
     }
   )
)
