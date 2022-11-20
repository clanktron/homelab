# Homelab

Kubernetes manifest files for my home environment
>currently managed by FluxCD

This repo works in junction with my [k3s-ansible](https://github.com/clanktron/k3s-ansible) repo.

If the cluster was created without the cilium helm installation run `cilium install` to install the service mesh on the cluster.

Next make sure the cluster is configured to decrypt sops secrets:

```bash
# manually create flux namespace
kubectl create ns flux-system

# Move to directory with sops agekey
cd <path-to-agekey-dir>

# pipe private agekey into kubernetes secret for sops decryption
cat age.agekey | kubectl create secret generic sops-age \
                --namespace=flux-system \
                --from-file=age.agekey=/dev/stdin
```

To bootstrap the cluster run:

```bash
export GITHUB_TOKEN=<personal_access_token>
flux bootstrap github --owner=clanktron --repository=homelab --path=clusters/prod/
```

### Useful notes:
To encrypt a secret using age run: 

```bash
export AGEPUBKEY=age17h94x54mrdkee8u9vu8rmnc58fn6lnxhkmkv75atv33kyaq309xq6v5ffn
sops --age=$AGEPUBKEY --encrypt --encrypted-regex '^(data|stringData)$' --in-place <file>
```

In the case of helm being stuck in 'pending-installation' state, delete the helm secrets and then allow flux to retry reconciliation or rerun helm command.

If a namespace is stuck (in a deleting state or other) run the following:
```
NAMESPACE=<your-rogue-namespace>
kubectl get namespace $NAMESPACE -o json |jq '.spec = {"finalizers":[]}' >temp.json
kubectl proxy &
curl -k -H "Content-Type: application/json" -X PUT \
    --data-binary @temp.json 127.0.0.1:8001/api/v1/namespaces/$NAMESPACE/finalize
```
