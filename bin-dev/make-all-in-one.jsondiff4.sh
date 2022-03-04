#!/bin/sh

basedir="$(readlink -f "$(dirname "$0")")/.."

export JQ_STACK4_MODDIR="$basedir/lib"
. "$basedir/deps/jq-helpers/lib/jq_stack4.lib.sh"

gen_json_flat_sorted() {
	set -- $1 json2flat hide_last_array_index sortallarrays json2ndjson
	jq_stack4 :else modcall "$@" :gen
}

{
echo '#!/bin/bash'
echo ''
echo 'json_flat_sorted() {'
echo '	jq $1 '"$(
		gen_json_flat_sorted |
		sed -e 's,^,\t,g' -e '1s,^\t,,g'
	)"
echo '}'
cat "$basedir/lib/jsondiff.lib.sh"
echo 'jsondiff "$@"'
} > "$basedir/bin/jsondiff.sh"

