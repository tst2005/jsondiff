
diff_txt2json() {
	#grep '^[+-]' | tail -n +3
	grep '^[+-]{' |
	sed -e 's/^\(.\)\(.*\)$/["\1", \2]/g'
}

#jsondiff() {
#	local f1="$1" f2="$2";shift 2
#	jq_run json2flat hide_last_array_index sortallarrays json2ndjson < "$f1"
#	jq_run json2flat hide_last_array_index sortallarrays json2ndjson < "$f2"
#}

#jq_run jq_cmd_ json2flat < "$1"
#jq_run jq_cmd_ json2flat hide_last_array_index < "$1"
#jq_run jq_cmd_ json2flat hide_last_array_index sortallarrays < "$1"
#jq_run jq_cmd_ json2flat hide_last_array_index sortallarrays json2ndjson < "$1"

jsondiff() {
	local f1="$1" f2="$2";shift 2
	diff -u "$@" \
		<(jq_run json2flat hide_last_array_index sortallarrays json2ndjson < "$f1") \
		<(jq_run json2flat hide_last_array_index sortallarrays json2ndjson < "$f2") \
	| diff_txt2json
}

