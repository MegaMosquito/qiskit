all: run

# Set these to your own values first
JUPYTER_TOKEN=secr3t
DOCKERHUB_ID=ibmosquito

ARCH=$(shell uname -m)
ifeq ($(ARCH), armv7l)
    ARCH=arm32
else ifeq($(ARCH), x86_64)
    ARCH=amd64
else
    ARCH=unknown
endif

build: 
	docker build -t $(DOCKERHUB_ID)/qiskit_$(ARCH):1.0.0 -f Dockerfile.$(ARCH) .

dev: build
	-docker rm -f qiskit 2>/dev/null
	docker run -it -e JUPYTER_TOKEN=$(JUPYTER_TOKEN) -p 8888:8888 --name qiskit $(DOCKERHUB_ID)/qiskit_$(ARCH):1.0.0 /bin/bash

run:
	-docker rm -f qiskit 2>/dev/null
	docker run -d -e JUPYTER_TOKEN=$(JUPYTER_TOKEN) -p 8888:8888 --restart unless-stopped --name qiskit $(DOCKERHUB_ID)/qiskit_$(ARCH):1.0.0

push:
	docker push $(DOCKERHUB_ID)/qiskit_$(ARCH):1.0.0

check:
	@echo "Point your browser to: \"http://localhost:8888/\""

