#!/bin/bash
eval $(minikube docker-env)

docker build -t loco:v2 .

for file in *.yaml; do
    kubectl apply -f "$file"
done
