# spire-helm-charts

A helm chart repository for a SPIRE installation

# Helm repo

The Helm repository for this SPIRE installation is composed by the following Helm charts:

- spiffe-csi-driver
- spire-server
- spire-agent

## Managing helm charts

In order to leverage a helm chart from this repository, add the repository link to your `helm` client:

```shell
$ helm repo add spire https://alexandrealvino.github.io/spire-helm-charts/helm/pkg
```

To validate if the helm repository was added to your client:

```shell
$ helm repo list
NAME   	URL                                                             
spire   	https://alexandrealvino.github.io/spire-helm-charts/helm/pkg
```

View chart manifest:

```shell
$ helm show all spire/<chart-name>
```

### Installing helm chart

To install a `helm` chart from the repository run:

```shell
$ helm install -n <namespace> --create-namespace <chart-name> spire/<chart-name>
```

### Customize a helm chart

To customize a `helm` chart, first download the chart package:

```shell
$ helm pull spire/<chart-name>
```

Extract the .tar.tgz file:

```shell
$ tar -xvzf <package-name>.tgz
```

Edit the `values.yaml` file applying the wanted changes and upgrade/install the `helm` resource passing the modified chart:

```shell
$ helm upgrade -n <namespace> --install -f <package-directory>/values.yaml <chart-name> <package-directory>
```

### Deleting a helm resource

```shell
$ helm uninstall -n <namespace> <resource-name>
```
