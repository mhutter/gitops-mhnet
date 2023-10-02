ARGOCD_VERSION := v2.8.4

.PHONY: all
all: apps/argocd/install.yaml

.PHONY: apps/argocd/install.yaml
apps/argocd/install.yaml:
	curl -sSL -o "$@" "https://raw.githubusercontent.com/argoproj/argo-cd/$(ARGOCD_VERSION)/manifests/install.yaml"
