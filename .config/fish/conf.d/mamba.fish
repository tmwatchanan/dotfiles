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

function __auto_env_mamba_env --on-variable PWD --description 'Automatically mamba activate depending on the directory'
    status --is-command-substitution; and return

    mamba_activate $PWD
end
