
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active) [![Last-changedate](https://img.shields.io/badge/last%20change-2017--07--14-green.svg)](/commits/master) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) [![keybase verified](https://img.shields.io/badge/keybase-verified-brightgreen.svg)](https://gist.github.com/bhaskarvk/46fbf2ba7b5713151d7e) [![Travis-CI Build Status](https://travis-ci.org/bhaskarvk/docker.svg?branch=master)](https://travis-ci.org/bhaskarvk/docker) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/bhaskarvk/docker?branch=master&svg=true)](https://ci.appveyor.com/project/bhaskarvk/docker) [![minimal R version](https://img.shields.io/badge/R%3E%3D-3.1.0-6666ff.svg)](https://cran.r-project.org/) [![packageversion](https://img.shields.io/badge/Package%20version-0.0.9000-orange.svg?style=flat-square)](commits/master) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/docker)](https://cran.r-project.org/package=docker) [![](http://cranlogs.r-pkg.org/badges/grand-total/docker)](http://cran.rstudio.com/web/packages/docker/index.html)

`docker`: An R Package for Docker
=================================

The `docker` R package provides access to the [docker](https://www.docker.com/) [API](https://docs.docker.com/engine/api/) to programmatically control a docker engine from R. The docker engine could be running either locally or remotely. The `docker` package uses the [reticulate](https://rstudio.github.io/reticulate/) R package to invoke the [Python SDK](https://docker-py.readthedocs.io/en/stable/) for docker. Using the Python SDK allows the `docker` package to have a very minimal foot-print and yet allow complete docker API access. The package has been tested against docker engine running on [Linux](https://www.docker.com/docker-ubuntu) and [Microsoft Windows](https://www.docker.com/docker-windows) and should also work under [MacOS](https://www.docker.com/docker-mac).

Controlling a docker engine from withing R can be useful for ...

-   Writing automated unit/integration tests for R packages against running services in docker containers. The package author can start a docker container, execute the tests, and tear the container down, all from withing the R code of the test.
-   Another use case is easy access to containerized services as part of a researchers reproducible research workflow. Having access to a containerized service ensures that the research code executes identically regardless of where it's run.

Installation
------------

Release version

``` r
install.packages('docker')
```

OR development version

``` r
if(!require(devtools)) {
  install.packages("devtools")
}
devtools::install_github('bhaskarvk/docker')
```

Setup
-----

Before you can use this package you need to have Python 2.x (&gt;=2.7) or Python 3.x (&gt;=3.4) with the [docker](https://docker-py.readthedocs.io/en/stable/index.html) Python module which provides Python SDK for docker. A simple way to do this is using a [virtual environment](http://docs.python-guide.org/en/latest/dev/virtualenvs/). [virtualenvwrapper](http://docs.python-guide.org/en/latest/dev/virtualenvs/#virtualenvwrapper) makes setting up Python modules quite painless.

Once you have installed Python and setup `virtualenvwrapper` you need to create a new virtual environment and install the `docker` Python module in it.

``` bash
mkvirtualenv --python=/usr/bin/python3 docker
workon docker
pip install docker

# Test the SDK againsts a locally running docker
# You should have a locally running docker for this.
python -c 'import docker; print(docker.from_env().version())'
```

You should see something like below, provided you had a locally running docker engine.

    {'Os': 'linux', 'Arch': 'amd64', 'KernelVersion': '4.10.0-24-generic', 'GitCommit': '02c1d87', 'Version': '17.06.0-ce', 'BuildTime': '2017-06-23T21:19:04.990631145+00:00', 'MinAPIVersion': '1.12', 'GoVersion': 'go1.8.3', 'ApiVersion': '1.30'}

Example
-------

``` r
reticulate::use_virtualenv("docker")
library(docker)
client <- docker$from_env()
s <- client$containers$run("alpine", 'echo -n "Hello World!"', remove=TRUE)
print(s$decode("UTF-8"))
#> [1] "Hello World!"
```

Usage
-----

After you have a successful 'Hellow World!' displayed above, you can call every API supported by the Python SDK using reticulate. Please consult the documents for the SDK and the reticulate R package in the links given above.

Code of Conduct
---------------

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
