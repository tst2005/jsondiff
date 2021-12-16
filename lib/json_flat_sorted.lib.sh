
json_flat_sorted() {
	jq_run $([ "$1" != "-s" ] || echo ndjson2json) json2flat hide_last_array_index sortallarrays json2ndjson
}
