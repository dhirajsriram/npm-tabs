# NPM-Tabs

An autocompletion shell script that autocoplete the commands based on the scripts declared in the package.json file.

## Requirement

- Jq
- Terminal that runs shell script (Support for windows under development)

## Installation

- Place the npm-tabs.sh file in the root directory alongside package.json
- Install Jq either using brew (Mac) or chocolatey (Windows) or by apt-get
```
source npm-tabs.sh
```
- Now while typing npm run (default command to run npm scripts) press tab to show the list of suggested commands

## Example

![alt text](/Npm-autocompletion.PNG)

## Snippets

### Get the npm script names as an array
``` sh
sample=`cat package.json`
arr=()
arr=($(echo "${sample}" | jq -r ' .scripts |keys | join(" ")'))
```
### Autocomplete based on the array
``` sh
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
```
