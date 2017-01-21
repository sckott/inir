context("ini")

test_that("ini works", {
  file1 <- system.file("examples", "example1.ini", package = "inir")
  res <- ini(file1)

  expect_is(res, "Ini")
  expect_is(res, "R6")
  expect_is(res$file, "character")
  expect_match(res$file, "example1.ini")
  expect_named(res, c('.__enclos_env__', 'parsed', 'file', 'clone',
                      'write', 'get', 'sections', 'read', 'print',
                      'initialize', 'self'))
  expect_true(is.na(res$parsed))

  res$read()

  expect_false(is.na(res$parsed))
  expect_is(res$parsed, "list")
  expect_named(res$parsed, "example1.ini")

  expect_is(res$sections(), "character")
  expect_equal(length(res$sections()), length(res$parsed$example1.ini))
})

test_that("ini fails well", {
  file <- tempfile(fileext = ".txt")
  cat("hello world", file = file)
  tmp <- ini(file)
  expect_error(tmp$read(), "You sure this is a INI file?")

  expect_error(ini(), "argument \"path\" is missing")
})

