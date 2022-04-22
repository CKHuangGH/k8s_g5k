#!/bin/bash 

for i in {0..1}
do
    string=$string"/root/.kube/cluster$i:"
done
string=$string | sed "s/.$//g"
KUBECONFIG=$string kubectl config view --flatten > ~/.kube/config

for i in {0..1}
do
kubectl config rename-context k8s-admin-cluster$i@kubernetes cluster$i
done

# Install helm3
wget --tries=0 https://github.com/helm/helm/releases/download/v3.8.2/helm-v3.8.2-linux-amd64.tar.gz.asc
tar xzvf helm-v3.8.2-linux-amd64.tar.gz.asc
mv linux-amd64/helm /usr/local/bin/
helm repo add stable https://charts.helm.sh/stable
helm repo add cilium https://helm.cilium.io/
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

# Deploy cilium
for i in {0..1}
do
kubectl config use-context cluster$i
helm repo update
helm install cilium cilium/cilium --version 1.11.3 --namespace kube-system --set cluster.name=cluster$i --set cluster.id=$i --wait
done

# Deploy Prometheus
for i in {0..1}
do
helm install --version 33.1.0 prometheus-community/kube-prometheus-stack --generate-name --set grafana.service.type=NodePort --set grafana.service.nodePort=30099 --set prometheus.service.type=NodePort --set prometheus.prometheusSpec.scrapeInterval="5s" --namespace monitoring
done

#Install helm2
wget --tries=0 https://get.helm.sh/helm-v2.16.1-linux-amd64.tar.gz
tar xzvf helm-v2.16.1-linux-amd64.tar.gz
mv linux-amd64/helm /usr/local/bin/helm2

kubectl config use-context cluster0
cat << EOF | kubectl apply -f -
apiVersion: v1
kind: ServiceAccount
metadata:
  name: tiller
  namespace: kube-system
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: tiller
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
  - kind: ServiceAccount
    name: tiller
    namespace: kube-system
EOF

helm2 init --service-account tiller

# Install kubefedctl
wget --tries=0 https://github.com/kubernetes-sigs/kubefed/releases/download/v0.1.0-rc6/kubefedctl-0.1.0-rc6-linux-amd64.tgz
tar xzvf kubefedctl-0.1.0-rc6-linux-amd64.tgz
mv kubefedctl /usr/local/bin/

# Add helm chart
sleep 30
kubectl config use-context cluster0
helm2 repo add kubefed-charts https://raw.githubusercontent.com/kubernetes-sigs/kubefed/master/charts

# Deploy KubeFed
helm2 install kubefed-charts/kubefed --name-template kubefed --version=0.1.0-rc6 --namespace kube-federation-system

# Join clusters
sleep 30
for i in {1..5}
do
kubefedctl join cluster$i --cluster-context cluster$i --host-cluster-context cluster0 --v=2
done

echo "DONE. Kubernetes Federation is setup."
