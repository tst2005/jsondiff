
# alternative to gron : https://github.com/tomnomnom/gron

jq_option_gron='-r'
jq_function_gron='
	def gron:
		to_entries| map( "\(.key) = \(.value|tojson);" )|.[]
	;
'

# gron
jq_cmd_gron() {
	jq_stack option -r
	jq_stack function "$jq_function_gron"
	jq_stack call gron
}
jq_cmd2_gron() {
	jq_stack2 option -r
	jq_stack2 function "$jq_function_gron"
	jq_stack2 call gron
}
jq_cmd3_gron() {
	jq_stack3 option -r modcall gron
}
