create:
	minikube start --kubernetes-version=v1.32.2

open_argocd: argocd_password
	minikube service argocd-server -n argocd
argocd_password:
	kubectl -n argocd get secret argocd-initial-admin-secret -o json|jq .data.password -r|base64 -d;echo

open_grafana:
	minikube service grafana-service -n grafana
