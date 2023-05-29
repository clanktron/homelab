# Cloud Lab

The source of truth for my Kubernetes clusters. I use this to manage both my on-prem and cloud deployments. Manifests are configured in a modular fashion using [flux](https://github.com/fluxcd/flux2), [kustomize](https://github.com/kubernetes-sigs/kustomize/), and [helm](https://github.com/helm/helm) to allow for simple cross-cluster orchestration.

>I often use this repo in junction with my [k3s-ansible](https://github.com/clanktron/k3s-ansible) repository. Once the ansible script has created the cluster it can be bootstrapped with this one.

>If the cluster was created without a CNI, install cillum with its cli by running `cilium install`.

## Bootstrapping

```bash
# environment
export SOPS_AGE_KEY_FILE=path_to_agekey_file
export CLUSTER_NAME=flux_cluster_config_to_use
export GITHUB_TOKEN=personal_access_token

# manually create flux namespace
kubectl create ns flux-system
# create SOPS secret so flux can decrypt secrets
kubectl create secret generic sops-age --namespace=flux-system --from-file=$SOPS_AGE_KEY_FILE
# Now we can bootstrap the cluster with a single command
flux bootstrap github --owner=clanktron --repository=homelab --path=clusters/$CLUSTER_NAME
# or if using raw git repo (the full path must be specified)
flux bootstrap git --url=ssh://git@remote/home/git/homelab --path=clusters/$CLUSTER_NAME
```
