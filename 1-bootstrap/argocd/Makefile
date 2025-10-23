all: repo ns install
repo:
	helm repo add argo https://argoproj.github.io/argo-helm
	helm repo update
ns:
	kubectl create ns argocd --dry-run=client -o yaml | kubectl apply -f -
install:
	helm upgrade --install -n argocd argocd argo/argo-cd -f helm-values.yaml
uninstall:
	helm uninstall -n argocd argocd 

get_password:
	kubectl -n argocd get secret argocd-initial-admin-secret -o json|jq .data.password -r|base64 -d;echo
deploy_applications:
	kubectl apply -f ../../components/argocd/applications/
