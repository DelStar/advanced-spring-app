#!/bin/bash
#This Prometheus set up script assumes you are using minikube and its all set up 

# Start and update your cluster(context) to minikubeb by running:
minikube start

kubectl config set-context minikube

# Check the status of minikube
minikube status

# Add the prometheus helm repository by running:
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

# Update the Helm-Chart repositories
helm repo update

# Install prometheus controller
helm install prometheus prometheus-community/prometheus --create-namespace --namespace prometheus

# Confirm your pods and services by running:
kubectl get pods
kubectl get svc

# Expose the Prometheus server on the UI by running:
kubectl expose service prometheus-server --type=NodePort --target-port=9090 --name=prometheus-server-ext

# Generate the url to access Prometheus by running:
minikube service --url prometheus-server-ext -n prometheus


# Run this to confirm that the url works
curl 127.0.0.1:36035/metrics
