script_link="$( command readlink "$BASH_SOURCE" )" || script_link="$BASH_SOURCE"
apparent_sdk_dir="${script_link%/*}"
if [ "$apparent_sdk_dir" == "$script_link" ]; then
  apparent_sdk_dir=.
fi
sdk_dir="$( command cd -P "$apparent_sdk_dir" > /dev/null && command pwd -P )"
bin_path="$sdk_dir/bin"
if [[ ":${PATH}:" != *":${bin_path}:"* ]]; then
  export PATH=$bin_path:$PATH
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/Abhi/Documents/GitHub/wikiwiki/Django/wikienv/wikiproject/google-cloud-sdk/path.bash.inc' ]; then . '/Users/Abhi/Documents/GitHub/wikiwiki/Django/wikienv/wikiproject/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/Abhi/Documents/GitHub/wikiwiki/Django/wikienv/wikiproject/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/Abhi/Documents/GitHub/wikiwiki/Django/wikienv/wikiproject/google-cloud-sdk/completion.bash.inc'; fi
