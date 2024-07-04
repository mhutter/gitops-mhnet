# mhnet GitOps

## Bootstrap

```sh
kubectl create namespace argocd
kubectl -n argocd apply -k ./apps/argocd
kubectl -n argocd apply -f ./clusters/mhnet/00root.yaml
```

## Testing Renovate configs locally

1. Set `GITHUB_COM_TOKEN` to any [Personal access token](https://github.com/settings/tokens?type=beta)
1. Temporarily remove any `"local>..."` references from `.extends`
1. `LOG_LEVEL=debug npx renovate --platform=local`
