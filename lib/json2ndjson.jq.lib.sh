
# json2ndjson
jq_cmd_json2ndjson() {
	jq_stack option -c
	jq_stack call '.[]'
}
jq_cmd2_json2ndjson() {
	jq_stack2 option -c
	jq_stack2 call '.[]'
}
