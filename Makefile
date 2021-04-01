NS ?= ponte124
VERSION ?= stable
IMAGE_NAME ?= docker-systools
CONTAINER_NAME ?= docker-systools
CONTAINER_INSTANCE ?= manual

build:
	docker build --no-cache -t $(NS)/$(IMAGE_NAME):$(VERSION)-`arch` -f Dockerfile .

push:
	docker push $(NS)/$(IMAGE_NAME):$(VERSION)-`arch`

shell: 
	docker run --rm --name $(CONTAINER_NAME)-$(CONTAINER_INSTANCE) -i -t $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(IMAGE_NAME):$(VERSION)-`arch` /bin/bash

run: 
	docker run --rm --name $(CONTAINER_NAME)-$(CONTAINER_INSTANCE) $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(IMAGE_NAME):$(VERSION)-`arch`

start: 
	docker run -d --name $(CONTAINER_NAME)-$(CONTAINER_INSTANCE) $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(IMAGE_NAME):$(VERSION)-`arch`

stop:
	docker stop $(CONTAINER_NAME)-$(CONTAINER_INSTANCE)

rm:
	docker rm $(CONTAINER_NAME)-$(CONTAINER_INSTANCE)

k8sdeploy:
	kubectl apply -f k8s-dksystools-deploy.yaml

uninstall:
	kubectl delete -f k8s-dksystools-deploy.yaml

default: run
