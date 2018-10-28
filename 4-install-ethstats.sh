#!/bin/bash

# Environment
. ./0-environment.sh

echo "===== Installing Ethstats Dashboard ====="
oc apply -f install/210-ethstats-service.yml
oc apply -f install/220-ethstats-secret.yml	
oc apply -f install/230-ethstats-deployment.yml

#oc apply -f install/240-ethstats-ingress.yml
oc expose svc eth-ethstats
