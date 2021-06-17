
# json2ndjson
jq_cmd_json2ndjson() {
	jq_stack option -cMS
	jq_stack call 'if type=="array" then .[] else . end'
}
jq_cmd2_json2ndjson() {
	jq_stack2 option -cMS
	jq_stack2 call 'if type=="array" then .[] else . end'
}
