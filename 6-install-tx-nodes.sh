#!/bin/bash

# Environment
. ./0-environment.sh

echo "===== Installing Transaction Nodes ====="
oc apply -f install/410-geth-tx-service.yml
oc apply -f install/420-geth-tx-deployment.yml
