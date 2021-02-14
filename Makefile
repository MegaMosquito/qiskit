all: run

# Set these to your own values first
JUPYTER_TOKEN=secr3t
DOCKERHUB_ID=ibmosquito

build: 
	docker build -t $(DOCKERHUB_ID)/qiskit_arm:1.0.0 -f Dockerfile.arm .

dev: build
	-docker rm -f qiskit 2>/dev/null
	docker run -it -e JUPYTER_TOKEN=$(JUPYTER_TOKEN) -p 8888:8888 --name qiskit $(DOCKERHUB_ID)/qiskit_arm:1.0.0 /bin/bash

run:
	-docker rm -f qiskit 2>/dev/null
	docker run -d -e JUPYTER_TOKEN=$(JUPYTER_TOKEN) -p 8888:8888 --name qiskit $(DOCKERHUB_ID)/qiskit_arm:1.0.0

push:
	docker push $(DOCKERHUB_ID)/qiskit_arm:1.0.0

check:
	@echo "Point your brwser to: \"http://localhost:8888/\""

