
jq_function_json2flat='
	def json2flat:
		.|reduce ( tostream|select(length==2) ) as $i ( {}; .[ $i[0]|map(
			if type=="number" then
				"[" + tostring + "]"
			elif (tostring|test("^[a-zA-Z0-9_]*$")) then
				"." + tostring
			else
				"[" + tojson + "]"
			end
		) | join("")] = $i[1] )
	;
'

# json2flat
jq_cmd_json2flat() {
	jq_stack option -S
	jq_stack function "$jq_function_json2flat"
	jq_stack call json2flat
}
jq_cmd2_json2flat() {
	jq_stack2 option -S
	jq_stack2 function "$jq_function_json2flat" named json2flat
	jq_stack2 call json2flat
}
