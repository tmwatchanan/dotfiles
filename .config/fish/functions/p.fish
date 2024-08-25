function p
    set dir_name $argv[1]
    set env_name $dir_name
    if test $argv[2]; set env_name $argv[2]; end
	z $dir_name
    conda activate $env_name
end

