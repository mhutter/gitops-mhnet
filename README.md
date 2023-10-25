# mhnet GitOps


## Bootstrap

```sh
kubectl create namespace argocd
kubectl -n argocd apply -k ./apps/argocd
kubectl -n argocd apply -f ./clusters/mhnet/00root.yaml
```

To generate a private key for SOPS:
```sh
age-keygen | kubectl -n argocd create secret generic sops-age --from-file=keys.txt=/dev/stdin
```

If you need to edit encrypted secrets, first extract the private key:

```sh
export SOPS_AGE_KEY="$(kubectl -n argocd get secret/sops-age -o json | jq -r '.data."keys.txt"|@base64d' | grep -v '^#')"
```
