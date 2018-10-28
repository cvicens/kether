#!/bin/bash

# Environment
. ./0-environment.sh

oc new-project ${PROJECT_NAME}

# A bootnode is a “Stripped down version of our Ethereum client implementation that only takes part in the network node discovery protocol, 
# but does not run any of the higher level application protocols. It can be used as a lightweight bootstrap node to aid in finding peers 
# in private networks.”
echo "===== Installing bootnode ====="
# The Bootnode Service provides the endpoints eth-bootnode:30301 and eth-bootnode:8080 to Pod with the selector eth-bootnode 
# defined further down in the Bootnode Deployment.
echo ">>> Creating the Bootnode Service"
oc apply -f install/110-bootnode-service.yml
# Bootnode Deployment: Bootnode Pods use the official ethereum/client-go Docker container, in this case, version alltools-release-1.8. 
# Bootnode Pods start with an initialization container (initContainers section) named genkey. The genkey init container run the 
# command bootnode --genkey=/etc/bootnode/node.key.
echo ">>> Creating the Bootnode Deployment"
oc apply -f install/120-bootnode-deployment.yml
# Bootnode Registrar: bootnode-registrar is a “Registrar for Geth Bootnodes. bootnode-registrar resolves a DNS address record to a 
# enode addresses that can then be consumed by geth –bootnodes=.” written by Jason Poon.
echo ">>> Creating the Registrar Service"
oc apply -f install/130-bootnode-registrar-service.yml
# The Bootnode Registrar Deployment uses the bootnode-registrar container. bootnode-registrar is open source and you can quickly 
# build a custom container with the provided Dockerfile. In this configuration uses the pre-built container provided.
# If you are using a custom namespace be sure to change the BOOTNODE_SERVICE environment variable to the namespace you are 
# using: “eth-bootnode.kether.svc.cluster.local”.
# The bootnode-registrar Pod runs a single Docker container named bootnode-registrar, running the jpoon/bootnode-registrar:v1.0.0 image 
# from Docker hub.
echo ">>> Creating the Bootnode Deployment"
oc apply -f install/140-bootnode-registrar-deployment.yml