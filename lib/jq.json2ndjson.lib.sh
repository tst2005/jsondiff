
# json2ndjson
jq_cmd_json2ndjson() {
	jq_stack option -c
	jq_stack call '.[]'
}
