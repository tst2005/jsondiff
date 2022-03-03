#!/bin/sh

basedir="$(readlink -f "$(dirname "$0")")/.."

#!/bin/bash

basedir="$(dirname "$0")/.."

export JQ_STACK4_MODDIR="$basedir/lib"
. "$basedir/deps/jq-helpers/lib/jq_stack4.lib.sh"

json_flat_sorted() {
	jq_stack4 :with external
	jq_stack4 $([ "$1" != "-s" ] || echo :modcall ndjson2json) :modcall json2flat :modcall hide_last_array_index :modcall sortallarrays :modcall json2ndjson
	jq_stack4 :gen
}

{
echo '#!/bin/bash'
echo ''
echo 'json_flat_sorted() {'
echo '	jq $1 '"$(
		json_flat_sorted |
		sed -e 's,^,\t,g' -e '1s,^\t,,g'
	)"
echo '}'
cat "$basedir/lib/jsondiff.lib.sh"
echo 'jsondiff "$@"'
} > "$basedir/bin/jsondiff.sh"

