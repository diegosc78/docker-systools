NS ?= ponte124
VERSION ?= latest
IMAGE_NAME ?= docker-systools
CONTAINER_NAME ?= docker-systools
CONTAINER_INSTANCE ?= manual

build:
	docker build --no-cache -t $(NS)/$(IMAGE_NAME):$(VERSION) -f Dockerfile .

push:
	docker push $(NS)/$(IMAGE_NAME):$(VERSION)

shell: 
	docker run --rm --name $(CONTAINER_NAME)-$(CONTAINER_INSTANCE) -i -t $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(IMAGE_NAME):$(VERSION) /bin/bash

run: 
	docker run --rm --name $(CONTAINER_NAME)-$(CONTAINER_INSTANCE) $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(IMAGE_NAME):$(VERSION)

start: 
	docker run -d --name $(CONTAINER_NAME)-$(CONTAINER_INSTANCE) $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(IMAGE_NAME):$(VERSION)

stop:
	docker stop $(CONTAINER_NAME)-$(CONTAINER_INSTANCE)

rm:
	docker rm $(CONTAINER_NAME)-$(CONTAINER_INSTANCE)

k8sdeploy:
	kubectl apply -f k8s-dksystools-deploy.yaml

uninstall:
	kubectl delete -f k8s-dksystools-deploy.yaml

default: run
