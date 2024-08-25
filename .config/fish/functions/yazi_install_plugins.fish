function yazi_install_plugins
	set current_dir (pwd)

	mkdir -p $CONFIG_HOME/yazi/plugins
	for plugin_repo in "dedukun/relative-motions.yazi" \
						"Reledia/glow.yazi" \
						"Reledia/miller.yazi" \
						"dedukun/bookmarks.yazi"
		echo "Plugin `$plugin_repo`"
		set onwer (string split "/" $plugin_repo -f1)
		set repository (string split "/" $plugin_repo -f2)
		set plugin_dir "$CONFIG_HOME/yazi/plugins/$repository"
		if test -d $plugin_dir
			cd $plugin_dir && git pull
		else
			git clone "https://github.com/$plugin_repo.git" $plugin_dir
		end
	end

	cd $current_dir
end

