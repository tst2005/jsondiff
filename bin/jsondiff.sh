#!/bin/bash

json_flat_sorted() {
	jq $1 -S -cM 'def json2flat:
		reduce ( tostream|select(length==2) ) as $i ( {}; .[ $i[0]|map(
			if type=="number" then
				"[" + tostring + "]"
			elif (tostring|test("^[a-zA-Z0-9_]*$")) then
				"." + tostring
			else
				"[" + tojson + "]"
			end
		) | join("")] = $i[1] )
	;def hide_last_array_index:
		to_entries
		| map(.key|= gsub("\\[([0-9]+)\\]$";"[]"))
		| map( [.key, .value] )
		| map_values( {"key": .[0], "value": .[1] } )
		| map([.]|from_entries)
	;def walk(f):
		. as $in
		| if type == "object" then
			reduce keys[] as $key
				( {}; . + { ($key):  ($in[$key] | walk(f)) } ) | f
		elif type == "array" then map( walk(f) ) | f
		else f
		end
	;
	def sortallarrays:
		walk(if type == "array" and length > 1 then sort else . end)
	;json2flat|hide_last_array_index|sortallarrays|if type=="array" then .[] else . end'
}

diff_txt2json() {
	#grep '^[+-]' | tail -n +3
	grep '^[+-]{' |
	sed -e 's/^\(.\)\(.*\)$/["\1", \2]/g'
}

jsondiff() {
	local s=''
	while [ $# -gt 0 ]; do
		case "$1" in
		(-s|--slurp|--ndjson) s='-s';;
		(--) shift;break;;
		(--help) echo >&2 "Usage: jsondiff [-s|--slurp|--ndjson] <jsonfile1> <jsonfile2>";return 0;;
		(-*) echo >&2 "invalid option $1"; return 1;;
		(*) break;;
		esac
		shift
	done
	if [ $# -lt 2 ]; then
		echo >&2 "Missing argument"
		return 1
	fi
	local f1="$1" f2="$2";shift 2
	diff -u "$@" \
		<(json_flat_sorted $s < "$f1") \
		<(json_flat_sorted $s < "$f2") \
	| diff_txt2json
}
jsondiff "$@"
