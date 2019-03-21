#'brew install jq' Installation for mac // Uncomment the first time
sample=`cat package.json`
arr=()
arr=($(echo "${sample}" | jq -r ' .scripts |keys | join(" ")'))
_UseGetOpt-2 ()
{
  local cur
  cur=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( $( compgen -W '${arr[*]}' $cur))
  case "$cur" in
    -*)
    COMPREPLY=( $( compgen -W '-a -d -f -l -t -h --aoption --debug \
                               --file --log --test --help --' -- $cur ) );
  esac
  return 0
}

complete -F _UseGetOpt-2 -o filenames npm run

