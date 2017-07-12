.libPaths(c("C:/RLibrary",.libPaths()))
.libPaths()
library(reticulate)
py_discover_config("docker")
library(docker)

# helper function to skip tests if we don't have the 'docker' module
skip_if_no_docker_module <- function() {
  have_docker <- py_module_available("docker")
  if (!have_docker)
    skip("Skipping test: Python 'docker' module not found")
}

skip_if_no_docker_engine <- function() {
  skip_if_no_docker_module()
  c <- docker$from_env()
  if(!c$ping()) {
    skip("Skipping test: No Docker engine found")
  }
}

skip_os_platform <- function(platform = 'windows') {
  if(platform == .Platform$OS.type) {
    skip(paste0("Skipping test: Unsupported platform:", platform))
  }
}

context("Hello World")

test_that("docker python module is loaded", {
  skip_if_no_docker_module()
  expect_true(is.object(docker))
  expect_true(!is.null(docker$version))
})

test_that("docker API litmus test passes on *nix", {
  skip_if_no_docker_engine()
  skip_os_platform("windows")
  c <- docker$from_env()
  s <- c$containers$run('alpine', 'echo -n "Hello World!"', remove=TRUE)
  expect_match(s$decode("UTF-8"), "Hello World!")
})

test_that("docker API litmus test passes on windows", {
  skip_if_no_docker_engine()
  skip_os_platform("unix")
  c <- docker$from_env()
  s <- c$containers$run('microsoft/nanoserver', 'CMD /q /c echo "Hello World!"', remove=TRUE)
  expect_match(s$decode("UTF-8"), "Hello World!")
})
