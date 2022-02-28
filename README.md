# Primality Test Application

This is a Spring Boot Application thats expose an API endpoint that receives an JSON Integer as input and returns `true`
if the integer is a prime number and `false` if the integer is not a prime number, with a `HTTP 200 OK` status code. If
the sended integer is in a invalid format, or if the input is not a number, then a `HTTP 400 Bad Request` status code is
returned with an error message.

The application uses Redis for caching, Terraform for cloud resources provisioning, Docker for containerizing and 
Kubernetes with Helm for deploying the service.

The cloud service choosed was Amazon Web Services (AWS), with the specific Elastic Compute Cloud (EC2), Elastic 
Kubernetes Service (EKS) and ElastiCache (Redis) services.

### Public Endpoint
The public exposed endpoint is the `/api/prime/test` at the TCP 80 port at
`a5980deb73bd94ec3a5aad81755d83b8-482596687.us-east-1.elb.amazonaws.com` address.

### Local Endpoint
The exposed endpoint is the `/api/prime/test` at the TCP 8080 port of the host machine.

### How to configure your local environment
You must have installed:
* Docker Desktop v4.5.0
* Kubectl Client v1.22.5
* Helm v3.8.0
* AWS IAM Authenticator v0.5.5
* GNU Make v3.81

The first thing to do is fill in the Access Key and Secret Key in the `terraform.tf`, `provider.tf` and `config.tf`
files at the `.tf` folder. After that, you must run the following commands at the project root folder:

```shell
make terraform-config
make kubectl-config
```

### How to deploy the service to cloud
To deploy the service using Helm to AWS EKS Cluster, you need to run the folling command at the project root folder:

```shell
make helm-deploy
```

This command will output the public endpoint address and port where the service was deployed.

The service uses the public image hosted in [my public registry](https://hub.docker.com/repository/registry-1.docker.io/gertmuller88/prime-test/)
at Docker Hub. However, you can build a new image, publish it to any public registry and then modify the `values.yml`
file inside the `.helm/prime-test` folder so that the Helm deploy can use this new image.

If the new image can have the same name and will be published on Docker Hub, you can use the following command to build
and push this new image.

```shell
make docker-config
```

### How to run the service in Docker locally
To run the service locally in Docker using Docker Compose, you must run the folling command at the project root folder:

```shell
make docker-compose-up
```

And the following command to stop:

```shell
make docker-compose-down
```

### How to run the service locally
To run the service locally, you must provide a Redis local instance. For that, run the following command at the
project root folder:

```shell
make run-local-redis
```

Now you can run the project at your IDE.
You can run the following command to stop the Redis local instance:

```shell
make stop-local-redis
```
