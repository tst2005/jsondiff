
# json2ndjson
jq_cmd_json2ndjson() {
	jq_stack option -cM
	jq_stack call 'if type=="array" then .[] else . end'
}
jq_cmd2_json2ndjson() {
	jq_stack2 option -cM
	jq_stack2 call 'if type=="array" then .[] else . end'
}
