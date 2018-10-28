#!/bin/bash

# Environment
. ./0-environment.sh

oc new-project ${PROJECT_NAME}

echo "===== Installing Miner Nodes ====="
oc apply -f install/310-geth-configmap.yml
oc apply -f install/320-geth-miner-secret.yml
oc apply -f install/330-geth-miner-deployment.yml