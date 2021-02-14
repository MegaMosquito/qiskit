# qiskit

A docker container with QISKIT and Jupyter for Raspberry Pi. QISKIT is both a quantum simulator (so you can perform quantum computing experiments at home!) and a tool that simplifies interfacing with IBM's quantum computing services in the IBM cloud. The Quantum Experience link below will guide you through the latter if you are interested in using the Real Thing!

I just want to use the simulator for now, so I built this container to run on a Raspberry Pi 4B with 2GB RAM (with Raspberry Pi OS 10, buster).

The only prerequiste you need to install to use this container is docker. You can install docker on your Pi with this one command:

```
curl -sSL https://get.docker.com | sh
```

When done, I recommend running this command so the pi user can use docker withut sudo:

```
sudo usermod -aG docker pi
```

After executing that command, exit your shell and open a new shell. In that new shell and all subsequent shells you will be able to run `docker` commands without `sudo`. E.g., try this:

```
docker ps
```

## To build this container

NOTE: You need a little more than 2GB of RAM to build the docker container. A 4GB or 8GB Pi won't need this step. Since I am using a 2GB machine, I increased the swap space with these commands:

```
sudo sed -i 's/CONF_SWAPSIZE=100/CONF_SWAPSIZE=1024/' /etc/dphys-swapfile
sudo /etc/init.d/dphys-swapfile stop
sudo /etc/init.d/dphys-swapfile start
```

Once you have that sorted out, these are the build steps:

1. Edit the Makefile to set your DockerHub ID in `DOCKERHUB_ID`

2. Edit the Makefile to set the `JUPYTER_TOKEN`. This is the token you will use to login to the Jupyter Notebook created by this container. So keep it secret. Keep it safe. :-)

3. Run `make build` (and expect this to take a very long time).

## To run the resulting container

```
make run
```

## To use the container

Point your favorite browser at `<raspberry-pi-address>:8888/`. Enter the `JUPYTER_TOKEN` value you set in the Makefile, and you will see the familiar Jupyter Notebooks interface. There is once example notebook provided, `quantum_not_gate_qiskit.ipynb`. You can select it and run through it to verify everything is working.

## To learn more

This YouTube video gives a brief QISKIT primer:
    [https://www.youtube.com/watch?v=V3hXSftZuoc](https://www.youtube.com/watch?v=V3hXSftZuoc)

I took the quantum NOT gate example from this set of guided exercises:
    [https://github.com/JavaFXpert/qiskit4devs-workshop-notebooks](https://github.com/JavaFXpert/qiskit4devs-workshop-notebooks)

The IBM Quantum Experience getting started guide:
    [https://quantum-computing.ibm.com/docs/](https://quantum-computing.ibm.com/docs/)


