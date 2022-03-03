
jq_option_json2ndjson='-cM'
jq_function_json2ndjson='def json2ndjson: if type=="array" then .[] else . end;'

# json2ndjson
jq_cmd_json2ndjson() {
	jq_stack option -cM
	jq_stack call 'if type=="array" then .[] else . end'
}
jq_cmd2_json2ndjson() {
	jq_stack2 option -cM
	jq_stack2 call 'if type=="array" then .[] else . end'
}
jq_cmd3_json2ndjson() {
	jq_stack3 option -cM call 'if type=="array" then .[] else . end'
}
jq_cmd4_json2ndjson() {
	${self:-jq_stack4} :modcall json2ndjson
}
