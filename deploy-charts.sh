#!/bin/bash

DIR="./helm"

kind create cluster

kubectl create namespace spire

helm upgrade --install -f "$DIR"/spire/spire-server/values.yaml spire-server "$DIR"/spire/spire-server/ -n spire
kubectl rollout status statefulset -n spire spire-server

helm upgrade --install -f "$DIR"/spire/spiffe-csi-driver/values.yaml spiffe-csi-driver "$DIR"/spire/spiffe-csi-driver/ -n spire
helm upgrade --install -f "$DIR"/spire/spire-agent/values.yaml spire-agent "$DIR"/spire/spire-agent/ -n spire
kubectl rollout status daemonset -n spire spire-agent

helm upgrade --install -f "$DIR"/istio/base-1.14.4/base/values.yaml base "$DIR"/istio/base-1.14.4/base/
helm upgrade --install -f "$DIR"/istio/istiod-1.14.4/istiod/values.yaml istiod "$DIR"/istio/istiod-1.14.4/istiod/ -n istio-system
kubectl -n istio-system rollout status deployment istiod
sleep 10
helm upgrade --install -f "$DIR"/istio/gateway-1.14.4/gateway/values.yaml ingressgateway "$DIR"/istio/gateway-1.14.4/gateway/ -n istio-system
kubectl -n istio-system rollout status deployment ingressgateway

kubectl label namespace default istio-injection=enabled --overwrite
