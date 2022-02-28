terraform-config: terraform-init terraform-refresh terraform-plan terraform-apply

terraform-init:
	@terraform -chdir=.tf/ init

terraform-refresh:
	@terraform -chdir=.tf/ refresh

terraform-plan:
	@terraform -chdir=.tf/ plan

terraform-apply:
	@terraform -chdir=.tf/ apply -auto-approve

kubectl-config: kube-mkdir terraform-output-kubeconfig terraform-output-configmap kubectl-apply-configmap kubectl-install-metrics-server

kube-mkdir:
	@mkdir -p ~/.kube/

terraform-output-kubeconfig:
	@terraform -chdir=.tf/ output -raw kubeconfig > ~/.kube/config

terraform-output-configmap:
	@terraform -chdir=.tf/ output -raw config_map_aws_auth > .k8s/configmap.yml

kubectl-apply-configmap:
	@kubectl apply -f .k8s/configmap.yml

kubectl-install-metrics-server:
	@kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

helm-deploy: helm-install kubectl-get-url

helm-install:
	@helm upgrade --install prime-test .helm/prime-test

kubectl-get-url:
	@echo $(shell kubectl get service prime-test-loadbalancer -o jsonpath={'.status.loadBalancer.ingress[].hostname'}):$(shell kubectl get service prime-test-loadbalancer -o jsonpath={'.spec.ports[].port'})

docker-config: docker-login docker-build docker-push

docker-login:
	@docker login

docker-build:
	@docker build -t gertmuller88/prime-test:latest -f .docker/Dockerfile .

docker-push:
	@docker push gertmuller88/prime-test:latest

docker-compose-build:
	@docker compose --file .docker/docker-compose.yml build

docker-compose-up:
	@docker compose --file .docker/docker-compose.yml up --detach --build --force-recreate --remove-orphans

docker-compose-down:
	@docker compose --file .docker/docker-compose.yml down --volumes --remove-orphans

docker-compose-start:
	@docker compose --file .docker/docker-compose.yml start

docker-compose-stop:
	@docker compose --file .docker/docker-compose.yml stop

docker-compose-config:
	@docker compose --file .docker/docker-compose.yml config

run-local-redis:
	@docker run --name redis-local -p 6379:6379 -d redis

stop-local-redis:
	@docker stop /redis-local

rm-local-redis:
	@docker rm /redis-local
