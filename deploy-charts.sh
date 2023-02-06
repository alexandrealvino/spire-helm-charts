#!/bin/bash

DIR="./helm"

kind create cluster

kubectl create namespace spire

helm upgrade --install -f "$DIR"/spire/spire-server/values.yaml spire-server "$DIR"/spire/spire-server/ -n spire
kubectl rollout status statefulset -n spire spire-server

helm upgrade --install -f "$DIR"/spire/spiffe-csi-driver/values.yaml spiffe-csi-driver "$DIR"/spire/spiffe-csi-driver/ -n spire
helm upgrade --install -f "$DIR"/spire/spire-agent/values.yaml spire-agent "$DIR"/spire/spire-agent/ -n spire
kubectl rollout status daemonset -n spire spire-agent
