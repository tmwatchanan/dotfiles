function mamba_activate
    set -l mamba_directory_environments \
        'dev/preda=preda' \
        'dev/ds-project-template=template' \
        'dev/sequential-recommender=trec' \
        'dev/i18n=i18n' \
        'dev/ranker=ranker' \
        'dev/llmaas=llm' \
        'dev/real-time-recommender=rt-rec'
    for pair in $mamba_directory_environments
        set -l key (string split '=' $pair)[1]
        set -l value (string split '=' $pair)[2]
        if string match -q "*$key*" "$argv[1]"
            mamba activate $value
        end
    end
end

function activate_environment
    if test -n "$VIRTUAL_ENV"
        deactivate
        if test -z "$CONDA_PREFIX"
            mamba activate base
        end
    end
    if test -n "$CONDA_PREFIX"
        set -l env_names (string split "/" "$CONDA_PREFIX")
        if [ $env_names[-1] != "base" ] 
            mamba deactivate
        end
    end

    if test -e .venv/bin/activate.fish
        if test -n "$CONDA_PREFIX"
            mamba deactivate
        end
        source .venv/bin/activate.fish
    else
        mamba_activate $PWD
    end
end

function __auto_env_python_env --on-variable PWD --description 'Automatically activate venv or mamba env depending on the directory'
    status --is-command-substitution; and return
    activate_environment
end