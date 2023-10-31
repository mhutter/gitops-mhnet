# mhnet GitOps


## Bootstrap

```sh
kubectl create namespace argocd
kubectl -n argocd apply -k ./apps/argocd
kubectl -n argocd apply -f ./clusters/mhnet/00root.yaml
```
