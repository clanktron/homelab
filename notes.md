# Miscellaneous Notes

Update all kustomize files:
```bash
find . -type f -name kustomization.yaml -exec gsed -i 's/kustomize.config.k8s.io\/v1beta1/kustomize.config.k8s.io\/v1/g' {} \;
```
