create:
	minikube start --kubernetes-version=v1.32.2


argocd_password:
	kubectl -n argocd get secret argocd-initial-admin-secret -o json|jq .data.password -r|base64 -d;echo
grafana_password:
	kubectl -n grafana get secret grafana-admin-credentials -o json|jq .data.GF_SECURITY_ADMIN_PASSWORD -r|base64 -d;echo 

open_argocd: argocd_password
	minikube service argocd-server -n argocd

open_grafana: grafana_password
	minikube service grafana-service -n grafana
open_prometheus:
	minikube service prometheus-server -n prometheus
