RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
if hash jq>/dev/null; then
    echo -e "${GREEN}✔ jq dependency found${NC}" 
else
    echo -e "${RED}No jq dependency found , Installing...${NC}"
    brew install jq
fi
sample=`cat ../../package.json`
arr=()
arr=($(echo "${sample}" | jq -r ' .scripts |keys | join(" ")'))
echo -e "${RED}${arr[*]}${NC} are the identified commands"
_UseGetOpt-2 ()
{
  local cur
  cur=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( $( compgen -W '${arr[*]}' $cur))
  case "$cur" in
    -*)
    COMPREPLY=( $( compgen -W '-a -d -f -l -t -h --aoption --debug \
                               --file --log --test --help --' --$cur ) );
  esac
  
  return 0
}

complete -F _UseGetOpt-2 filenames npm run
echo -e "${GREEN}✔ Automcomplete embedded to terminal. Try 'npm run ' and tab to start${NC}" 
cd ../..