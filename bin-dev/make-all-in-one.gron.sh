#!/bin/sh

basedir="$(readlink -f "$(dirname "$0")")/.."

. "$basedir/deps/jq-helpers/lib/jq_stack2.lib.sh"
. "$basedir/deps/jq-helpers/lib/jq_run2.lib.sh"

. "$basedir/lib/hide_last_array_index.jq.lib.sh"
. "$basedir/lib/json2flat.jq.lib.sh"
. "$basedir/lib/json2ndjson.jq.lib.sh"
. "$basedir/lib/ndjson2json.jq.lib.sh"
. "$basedir/lib/sortallarrays.jq.lib.sh"
. "$basedir/lib/gron.jq.lib.sh"

{
echo '#!/bin/sh'
echo ''
echo "jq $(jq_gen2 json2flat hide_last_array_index sortallarrays json2ndjson gron)"
} > "$basedir/bin/gron.sh"
chmod +x "$basedir/bin/gron.sh"
