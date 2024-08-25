function verda_prod --description 'access VKS production'
	source $HOME/dev/verda_data_prod-tokyo-fish.sh
	vksctl use dap-vks-release
	kubectl config use-context dap-vks-release-tokyo
end

