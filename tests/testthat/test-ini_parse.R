context("ini_parse")

test_that("ini_parse parses correctly", {
  file1 <- system.file("examples", "example1.ini", package = "inir")
  res <- ini_parse(file1)

  expect_is(res, "list")
  expect_named(res, "example1.ini")
  expect_is(res$example1.ini[[1]], "list")
  expect_is(res$example1.ini[[1]], "list")
  expect_is(res$example1.ini[[1]]$navigationaction, "character")

  file2 <- system.file("examples", "example2.ini", package = "inir")
  res2 <- ini_parse(c(file1, file2))

  expect_is(res2, "list")
  expect_named(res2, c("example1.ini", "example2.ini"))
  expect_is(res2$example1.ini[[1]], "list")
  expect_is(res2$example1.ini[[1]]$navigationaction, "character")
  expect_is(res2$example1.ini[[1]]$validsection, "character")
  expect_true(as.logical(res2$example1.ini[[1]]$validsection))
})

test_that("ini_parse fails well", {
  file <- tempfile(fileext = ".txt")
  cat("hello world", file = file)
  expect_error(ini_parse(file), "You sure this is a INI file?")
})

