.libPaths(c("C:/RLibrary",.libPaths()))
.libPaths()
library(testthat)
library(reticulate)
py_discover_config("docker")
library(docker)

test_check("docker")
