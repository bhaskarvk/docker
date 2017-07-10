library(reticulate)
use_virtualenv("docker")
library(docker)

# helper function to skip tests if we don't have the 'docker' module
skip_if_no_docker <- function() {
  have_docker <- py_module_available("docker")
  if (!have_docker)
    skip("docker not available for testing")
}

context("Hello World")

test_that("docker python module is loaded", {
  skip_if_no_docker()
  expect_true(is.object(docker))
  expect_true(!is.null(docker$version))
})

test_that("docker API litmus test passes", {
  skip_if_no_docker()
  c <- docker$from_env()
  s <- c$containers$run('alpine', 'echo -n "Hello World!"', remove=TRUE)
  expect_match(s$decode("UTF-8"), "Hello World!")
})
