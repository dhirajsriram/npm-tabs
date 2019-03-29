#!/usr/bin/env bash
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine="Linux";;
    Darwin*)    machine="Mac";;
    CYGWIN*)    machine="Cygwin";;
    MINGW*)     machine="MinGw";;
    *)          machine="UNKNOWN:${unameOut}"
esac

_ReadFile()
{
    sample=`cat ../../package.json`
    arr=()
    arr=($(echo "${sample}" | jq -r ' .scripts |keys | join(" ")'))
    echo -e "${RED}${arr[*]}${NC} are the identified commands"
    complete -F _UseGetOpt-2 filenames npm run
    echo -e "${GREEN}✔️ Automcomplete embedded to terminal. Try 'npm run ' and tab to start${NC}" 
    cd ../..
}

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

if hash jq>/dev/null; then
    echo -e "${GREEN}✔️ jq dependency found${NC}" 
    _ReadFile
else
    which brew;
    if [[ $? != 0 ]] ; then
        case $machine in
        MinGw)
            echo -e "${RED}! You need to install jq for Windows. Visit the link for instructions : https://stedolan.github.io/jq/download/${NC}"
            ;;
        Cygwin)
            echo -e "${RED}! You need to install jq for Windows. Visit the link for instructions : https://stedolan.github.io/jq/download/${NC}"
            ;;
        Mac)
            echo -e "${RED}! No jq dependency found , Installing...${NC}"
            /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
            brew install jq
            echo -e "${GREEN}✔️ jq dependency installed${NC}"
            _ReadFile
            ;;
        esac
    else
        brew install jq
        echo -e "${GREEN}✔️ jq dependency installed${NC}"
        _ReadFile 
    fi
fi

