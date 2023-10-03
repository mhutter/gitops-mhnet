ARGOCD_VERSION := v2.8.4

.PHONY: help
help: ## Show this help
	@grep -E -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: all
all: apps/argocd/install.yaml

.PHONY: apps/argocd/install.yaml
apps/argocd/install.yaml:  ## Update ArgoCD manifest
	curl -sSL -o "$@" "https://raw.githubusercontent.com/argoproj/argo-cd/$(ARGOCD_VERSION)/manifests/install.yaml"

sops:  ## Update SOPS config
	$(eval PUBLIC_KEY = $(shell kubectl -n argocd get secret/sops-age -o json | \
		jq -r '.data."keys.txt"|@base64d' | \
		awk '/public key/{print $$4}'))
	sed -E -i 's/age:.+$$/age: $(PUBLIC_KEY)/' .sops.yaml
