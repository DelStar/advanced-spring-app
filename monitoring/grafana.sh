#!/bin/bash
# This Grafana set-up script assumes you are using minikube and its all set up

# Add the Grafana Helm repository
helm repo add grafana https://grafana.github.io/helm-charts

# Update the Helm-Chart repositories
helm repo update

# Install Grafana with helm
helm install grafana grafana/grafana --create-namespace --namespace grafana

# Expose the Grafana server on the UI by running:
kubectl expose service grafana --type=NodePort --target-port=3000 --name=grafana-ext

# Generate the url to access Grafana by running:
minikube service --url grafana-ext -n grafana

# Get your 'admin' user password by running:
kubectl get secret --namespace grafana grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

# On Grafana dashboard, link prometheus server as a data source, using the [<minikubeip>:<nodeport-number>] url
# Go to dashboard, click 'import' to use a template/sample dashboard from grafana.com using the ID: 3662