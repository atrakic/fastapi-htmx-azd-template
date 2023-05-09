test:
	if ! [ -x "$$(command -v azd)" ]; then curl -fsSL https://aka.ms/install-azd.sh | bash; fi
	azd auth login --check-status || azd auth login
	terraform init -backend=false -upgrade
	terraform plan -lock=false -var-file test.tfvars

clean:
	rm -rf .terraform
