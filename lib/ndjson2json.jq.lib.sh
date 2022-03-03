
jq_option_ndjson2json='-s'
jq_function_ndjson2json='def ndjson2json: .;'

# see http://ndjson.org/
jq_cmd_ndjson2json() {
	jq_stack option -s
	#jq_stack call '.'
}
jq_cmd2_ndjson2json() {
	jq_stack2 option -s
	#jq_stack2 call '.'
}
jq_cmd3_ndjson2json() {
	jq_stack3 option -s
	#jq_stack3 call '.'
}
jq_cmd4_ndjson2json() {
	${self:-jq_stack4} :modcall ndjson2json
}
