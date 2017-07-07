#' This is the docker instance corresponding to [docker](https://docker-py.readthedocs.io/en/stable/index.html) module of the docker Python SDK.
#' @export
docker <- NULL

.onLoad <- function(libname, pkgname) {
  docker <<- reticulate::import("docker", delay_load = TRUE)
}
