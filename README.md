# mhnet GitOps


## Bootstrap

```sh
kubectl create namespace argocd
kubectl -n argocd apply -k ./apps/argocd
kubectl -n argocd apply - ./clusters/mhnet/00root.yaml
```

To generate a private key for SOPS:
```sh
age-keygen | kubectl -n argocd create secret generic sops-age --from-file=keys.txt=/dev/stdin
```

