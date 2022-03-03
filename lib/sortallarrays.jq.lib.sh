
jq_option_sortallarrays='-c'
jq_function_sortallarrays='
	# Apply f to composite entities recursively, and to atoms
	def walk(f):
		. as $in
		| if type == "object" then
			reduce keys[] as $key
				( {}; . + { ($key):  ($in[$key] | walk(f)) } ) | f
		elif type == "array" then map( walk(f) ) | f
		else f
		end
	;
	def sortallarrays:
		walk(if type == "array" and length > 1 then sort else . end)
	;
'

# sortallarrays
jq_cmd_sortallarrays() {
	jq_stack function "$jq_function_sortallarrays"
	jq_stack call sortallarrays
}
jq_cmd2_sortallarrays() {
	jq_stack2 function "$jq_function_sortallarrays" named sortallarrays
	jq_stack2 call sortallarrays
}
jq_cmd3_sortallarrays() {
	jq_stack3 modcall sortallarrays
}
jq_cmd4_sortallarrays() {
	${self:-jq_stack4} :modcall sortallarrays
}
