#' docker. Wraps Docker Python SDK.
#'
#' @description Allows accessing Docker SDK from R via the Docker [Python SDK](https://docker-py.readthedocs.io/en/stable/index.html) using the reticulate package. This is a very thin wrapper and relies on the user to understand how the Python SDK works and how the [reticulate](https://cran.r-project.org/package=reticulate) package is used to interface with python.
#'
#' @examples
#' \dontrun{
#' library(docker)
#' client <- docker$from_env()
#' client$containers$run('alpine', 'echo "Hello World!"')
#' }
#'
#' @name docker
#' @importFrom reticulate import
#' @docType package
NULL
