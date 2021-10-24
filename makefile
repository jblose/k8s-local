dep:
	terraform init

plan:
	terraform plan

apply:
	terraform apply

destroy:
	terraform destroy

reload:
	kubectl delete pod -n monitor -l app=prometheus

forward: 
	kubectl port-forward -n monitor service/kube-prometheus-stack-prometheus 9090