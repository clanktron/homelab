# Miscellaneous Notes

# TODO:
- filestash replaces filebrowser
    - onlyoffice integration? (low priority)

# Rename file extensions
```bash
# this example renames all .yml file to .yaml
find deprecated/ -depth -name "*.yml" -exec sh -c 'f="{}"; mv -- "$f" "${f%.yml}.yaml"' \;
```

## aws
```bash
# https://github.com/kubernetes-sigs/aws-ebs-csi-driver/blob/master/docs/install.md
kubectl create secret generic aws-secret \
    --namespace kube-system \
    --from-literal "key_id=${AWS_ACCESS_KEY_ID}" \
    --from-literal "access_key=${AWS_SECRET_ACCESS_KEY}"
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
## Security "Best" Practices (what ive come up with)
- use scratch container when possible
- use env vars for secrets
- if alpine is required (nodejs, python, etc)
    - binary should be run as user with minimum permissions

# Hardware

## Dell Optiplex 3020
- decomission and move hdd array to pve
- put back in its own case for use as reg node

## HP Compaq 8200 Elite SFF 
- replace boot drive with 2tb ssd (literally $64 which is crazy)
- 2tb hdd array was stupid and a waste of money
    - going to replace this with a couple 4 or 8tb ssds when prices get right

## HP EliteDesk 800 Gx Mini
- G2 and G3 are the most cost effective atm
- G2, G3, G4 are all great since they max out at 32gs of ram
- ram upgrade (2x16 sticks) can be bought from crucial for $57 (last I checked)

## Future Plans
- everything kubernetes (k3s)
- need a barebones OS...arch, nixos, karios, elemental, or maybe even talos????
- kubevirt for vm needs (nic stuff for router, etc)
