.PHONY: help
help: ## Show this help
	@grep -E -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

sops:  ## Update SOPS config
	$(eval PUBLIC_KEY = $(shell kubectl -n argocd get secret/sops-age -o json | \
		jq -r '.data."keys.txt"|@base64d' | \
		awk '/public key/{print $$4}'))
	sed -E -i 's/age:.+$$/age: $(PUBLIC_KEY)/' .sops.yaml
