# A hack to make CI builds work on windows/appveyor
# See https://github.com/krlmlr/r-appveyor/issues/91
.libPaths(c("C:/RLibrary",.libPaths()))

library(reticulate)
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

context("Hello World")

test_that("docker python module is loaded", {
  skip_on_cran()
  skip_on_bioc()
  skip_if_no_docker_module()
  expect_true(is.object(docker))
  expect_true(!is.null(docker$version))
})

test_that("docker API litmus test passes on *nix", {
  skip_on_cran()
  skip_on_bioc()
  skip_on_os("windows")
  skip_if_no_docker_engine()
  c <- docker$from_env()
  s <- c$containers$run('alpine', 'echo -n "Hello World!"', remove=TRUE)
  if(!inherits(s,'character')) { # python 2 vs 3
    s <- s$decode('UTF-8')
  }
  expect_match(s, "Hello World!")
})

test_that("docker API litmus test passes on windows", {
  skip_on_cran()
  skip_on_bioc()
  skip_on_os(c("linux", "mac", "solaris"))
  skip_if_no_docker_engine()
  c <- docker$from_env()
  s <- c$containers$run('microsoft/nanoserver', 'CMD /q /c echo "Hello World!"', remove=TRUE)
  if(!inherits(s,'character')) { # python 2 vs 3
    s <- s$decode('UTF-8')
  }
  expect_match(s, "Hello World!")
})
