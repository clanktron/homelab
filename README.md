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

- in the case of helm being stuck in 'pending-installation' state, delete the helm secrets and either allow flux to retry reconciliation or rerun helm command
