#!/bin/bash

DIR="./helm"

helm package "$DIR"/spire/spiffe-csi-driver/
helm package "$DIR"/spire/spire-server/
helm package "$DIR"/spire/spire-agent/

mv *.tgz "$DIR"/pkg/

helm repo index "$DIR"/pkg --url https://alexandrealvino.github.io/spire-helm-charts/helm/pkg
