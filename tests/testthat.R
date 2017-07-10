library(testthat)
library(reticulate)
use_virtualenv("docker")
library(docker)

test_check("docker")
