init:
	terraform12 init

plan: init
	terraform12 plan -out=wood320.tfplan

apply:
	terraform12 apply wood320.tfplan

destroy:
	terraform12 destroy