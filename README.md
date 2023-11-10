# Cloud Lab

The source of truth for my Kubernetes clusters. I use this to manage both my on-prem and cloud deployments. Manifests are configured in a modular fashion using [flux](https://github.com/fluxcd/flux2), [kustomize](https://github.com/kubernetes-sigs/kustomize/), and [helm](https://github.com/helm/helm) to allow for simple cross-cluster orchestration.

>I often use this repo in junction with my [k3s-ansible](https://github.com/clanktron/k3s-ansible) repository. Once the ansible script has created the cluster it can be bootstrapped with this one.

>If the cluster was created without a CNI, install cillum with its cli by running `cilium install`.

## Bootstrapping

```bash
# environment
export SOPS_AGE_KEY=path_to_agekey_file
export CLUSTER=flux_cluster_config_to_use
export SSH_KEY=path_to_ssh_key
# optional
export SSH_KEY_PASS=password_to_ssh_key_file

# manually create flux namespace
kubectl create ns flux-system
# create SOPS secret so flux can decrypt secrets
kubectl create secret generic sops-age --namespace=flux-system --from-file=$SOPS_AGE_KEY_FILE
# Now we can bootstrap the cluster with a single command
flux bootstrap git \
    --url=ssh://git@github.com/clanktron/homelab \
    --branch=kairos \
    --private-key-file="$SSH_KEY" \
    --password="$SSH_KEY_PASS" \
    --path=clusters/"$CLUSTER"
```
