# Miscellaneous Notes

# Rename file extensions
```bash
# this example renames all .yml file to .yaml
find deprecated/ -depth -name "*.yml" -exec sh -c 'f="{}"; mv -- "$f" "${f%.yml}.yaml"' \;
```

## Update all kustomize files:
```bash
find . -type f -name kustomization.yaml -exec gsed -i 's/kustomize.config.k8s.io\/v1beta1/kustomize.config.k8s.io\/v1/g' {} \;
```

## To encrypt a secret using age run: 

```bash
export AGEPUBKEY=age17h94x54mrdkee8u9vu8rmnc58fn6lnxhkmkv75atv33kyaq309xq6v5ffn
sops --age=$AGEPUBKEY --encrypt --encrypted-regex '^(data|stringData)$' --in-place <file>
```

## Helm stuck in 'pending-installation' state

Delete the helm secrets and then allow flux to retry reconciliation or rerun helm command.

If a namespace is stuck (in a deleting state or other) run the following:
```bash
NAMESPACE=your-rogue-namespace
kubectl get namespace $NAMESPACE -o json |jq '.spec = {"finalizers":[]}' >temp.json
kubectl proxy &
curl -k -H "Content-Type: application/json" -X PUT \
    --data-binary @temp.json 127.0.0.1:8001/api/v1/namespaces/$NAMESPACE/finalize
```
