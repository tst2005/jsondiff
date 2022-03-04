#!/bin/sh

basedir="$(readlink -f "$(dirname "$0")")/.."

export JQ_STACK4_MODDIR="$basedir/lib"
. "$basedir/deps/jq-helpers/lib/jq_stack4.lib.sh"

{
echo '#!/bin/sh'
echo ''
echo "jq $(
	jq_stack4 :else modcall json2flat hide_last_array_index sortallarrays json2ndjson gron :gen
)"
} > "$basedir/bin/gron.sh"
chmod +x "$basedir/bin/gron.sh"
