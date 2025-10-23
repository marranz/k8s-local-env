all: repo ns install deploy_applications
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
deploy_applications: create-repo-secret
	kubectl apply -f ../../components/argocd/applications/
create-repo-secret:
	kubectl create secret generic my-ssh-key-secret  --from-file=sshPrivateKey=$$HOME/.ssh/id_rsa  --namespace=argocd --from-literal=type=git --from-literal=url=git@github.com:marranz/k8s-local-env.git
	kubectl label secret my-ssh-key-secret  --namespace=argocd argocd.argoproj.io/secret-type=repository
