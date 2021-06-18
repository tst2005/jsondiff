
diff_txt2json() {
	#grep '^[+-]' | tail -n +3
	grep '^[+-]{' |
	sed -e 's/^\(.\)\(.*\)$/["\1", \2]/g'
}

jsondiff2() {
	if [ $# -lt 2 ]; then
		echo >&2 "Missing argument"
		return 1
	fi
	local f1="$1" f2="$2";shift 2
	diff -u "$@" \
		<(jq_run2 json2flat hide_last_array_index sortallarrays json2ndjson < "$f1") \
		<(jq_run2 json2flat hide_last_array_index sortallarrays json2ndjson < "$f2") \
	| diff_txt2json
}
