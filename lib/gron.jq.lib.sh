
# alternative to gron : https://github.com/tomnomnom/gron

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
