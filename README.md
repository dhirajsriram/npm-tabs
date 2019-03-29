# NPM-Tabs

An autocompletion shell script that autocompletes the commands based on the scripts declared in the package.json file.

## Requirement

- Jq
- Terminal that runs shell script (Support for windows under development)

## Running

- After installing the package , use the following command in the root folder of your application
```
cd node_modules/npm-tabs ; source npm-tabs.sh
````
*If it says 'source' is not recognized as an internal or external command. Try running the command from a bash terminal*

cygWin - https://www.cygwin.com/<br/>
git -  https://git-scm.com/download/win

- Now while typing npm run (default command to run npm scripts) press tab to show the list of suggested commands

## Example

![alt text](https://github.com/dhirajsriram/npm-tabs/blob/master/npmtabs.PNG?raw=true)

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
