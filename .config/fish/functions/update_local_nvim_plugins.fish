function update_local_nvim_plugins
	set current_dir (pwd)

	set local_plugin_dir ~/tm/nvim-plugins
	cd $local_plugin_dir
	for plugin_repo in */
		echo "Plugin `$plugin_repo`"
		cd $local_plugin_dir/$plugin_repo
		git pull
	end

	cd $current_dir
end

