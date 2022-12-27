

check_params:
	@if test -z "${TERRAFORM_PROVIDER}"; then echo "TERRAFORM_PROVIDER not set, example: https://github.com/hashicorp/terraform-provider-aws"; exit 1; fi

generate:: check_params install_selefra_terraform_provider_scaffolding generate_selefra_provider

install_selefra_terraform_provider_scaffolding::
	chmod u+x ./install-scaffolding.sh
	./install-scaffolding.sh

generate_selefra_provider::
	rm -rf ./tables
	rm -rf ./provider
	./bin/selefra-terraform-provider-scaffolding terraform-provider --url ${TERRAFORM_PROVIDER}

clean::
	rm -rf ./bin

help::
	@grep '^[^.#]\+:\s\+.*#' Makefile | \
 	sed "s/\(.\+\):\s*\(.*\) #\s*\(.*\)/`printf "\033[93m"`\1`printf "\033[0m"`	\3 [\2]/" | \
 	expand -t20

test::
