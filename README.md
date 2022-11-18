# Homelab

kubernetes manifest files for my home environment

currently managed by fluxCD

To bootstrap the cluster run:

```bash
export GITHUB_TOKEN=<personal_access_token>
flux bootstrap github --owner=clanktron --repository=homelab --path=clusters/prod/
```

To encrypt a secret using age run: 

```bash
export AGEPUBKEY=age17h94x54mrdkee8u9vu8rmnc58fn6lnxhkmkv75atv33kyaq309xq6v5ffn
sops --age=$AGEPUBKEY --encrypt --encrypted-regex '^(data|stringData)$' --in-place <file>
```

### Useful notes:

- in the case of helm being stuck in 'pending-installation' state, delete the helm secrets and then allow flux to retry reconciliation or rerun helm command
- in the case of stuck Namespace run the following 
```
NAMESPACE=your-rogue-namespace
kubectl proxy &
kubectl get namespace $NAMESPACE -o json |jq '.spec = {"finalizers":[]}' >temp.json
curl -k -H "Content-Type: application/json" -X PUT --data-binary @temp.json 127.0.0.1:8001/api/v1/namespaces/$NAMESPACE/finalize
```
