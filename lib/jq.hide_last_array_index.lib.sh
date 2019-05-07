
jq_function_hide_last_array_index='
	def hide_last_array_index:
        	to_entries
	        | map(.key|= gsub("\\[([0-9]+)\\]$";"[]"))
        	| map( [.key, .value] )
	        | map_values( {"key": .[0], "value": .[1] } )
        	| map([.]|from_entries)
	;
'

# hide_last_array_index
jq_cmd_hide_last_array_index() {
	jq_stack function "$jq_function_hide_last_array_index"
	jq_stack call hide_last_array_index
}
