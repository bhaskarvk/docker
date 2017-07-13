library(reticulate)
py_discover_config("docker")
library(docker)
library(rredis)

docker_client <- docker$from_env()
docker_client$ping()

redis_instance <- docker_client$containers$run(
  'redis', name='redis', detach=TRUE, ports=list('6379/tcp'='6379'))
redis_instance$status

Sys.sleep(5) # Wait for the container to start the service.

# For some reason I get an error the first time I connect
# but it works the second time, so calling redisConnect twice
redisConnect(host='127.0.0.1', port=6379, nodelay=TRUE)
redisConnect(host='127.0.0.1', port=6379, nodelay=TRUE)
redisSet('docker-test', rnorm(20))
redisGet('docker-test')

redis_instance$stop()
redis_instance$remove()
redis_instance <- NULL

