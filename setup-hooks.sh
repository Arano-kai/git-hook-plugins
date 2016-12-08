#! /usr/bin/env sh
set -e

# Setup hooks to local repo

# Find real path. Details on http://stackoverflow.com/a/29835459
rreadlink() ( 
target=$1 fname= targetDir= CDPATH=
{ \unalias command; \unset -f command; } >/dev/null 2>&1 || true
[ -n "$ZSH_VERSION" ] && options[POSIX_BUILTINS]=on 
while :; do 
	[ -L "$target" ] || [ -e "$target" ] || { command printf '%s\n' "ERROR: '$target' does not exist." >&2; return 1; }
	command cd "$(command dirname -- "$target")" 
	fname=$(command basename -- "$target") 
	[ "$fname" = '/' ] && fname='' 
	if [ -L "$fname" ]; then
		target=$(command ls -l "$fname")
		target=${target#* -> }
		continue 
	fi
	break 
done
targetDir=$(command pwd -P) 
if [ "$fname" = '.' ]; then
	command printf '%s\n' "${targetDir%/}"
elif  [ "$fname" = '..' ]; then
	command printf '%s\n' "$(command dirname -- "${targetDir}")"
else
	command printf '%s\n' "${targetDir%/}/$fname"
fi
)

hooks_source="$(dirname -- $(rreadlink ${0}))/hooks"
hooks_dest="${1:-$(git rev-parse --show-toplevel)/.git}/hooks"

if [ ! -e ${hooks_source} ] && [ -d ${hooks_source} ]; then
   printf "%s\n"	"Something bad happens..."\
					"Missed '${hooks_source}', which is hooks source dir!"
	exit 1
fi

if [ ! -e ${hooks_dest} ] || [ ! -d ${hooks_dest} ]; then
	printf "%s\n"	"Local hooks dir '${hooks_dest}' not exist/not a dir!"\
					"If You use '--git-dir' option, please specify full path to Your '.git' dir as argument fot this script."
	exit 1
fi

for type in f l; do
	for hook in $(find "${hooks_source}/" -maxdepth 1 -type ${type} -print); do
		target="${hooks_dest}/$(basename -- ${hook})"
		[ -e "${target}" ] && printf "%s\n" "'${target}' already exists, skipping..." && continue
		printf "%s\n" "Setting up $(basename -- ${hook})."
		[ -L "${hook}" ] && cp -P "${hook}" "${target}" || ln -s "${hook}" "${target}"
	done
done
