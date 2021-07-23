#!/bin/sh

jq -S -cM -r 'def json2flat:
	reduce ( tostream|select(length==2) ) as $i ( {}; .[ $i[0]|map(
		if type=="number" then
			"[" + tostring + "]"
		elif (tostring|test("^[a-zA-Z0-9_]*$")) then
			"." + tostring
		else
			"[" + tojson + "]"
		end
	) | join("")] = $i[1] )
;def hide_last_array_index:
	to_entries
	| map(.key|= gsub("\\[([0-9]+)\\]$";"[]"))
	| map( [.key, .value] )
	| map_values( {"key": .[0], "value": .[1] } )
	| map([.]|from_entries)
;def walk(f):
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
;def gron:
	to_entries| map( "\(.key) = \(.value|tojson);" )|.[]
;json2flat|hide_last_array_index|sortallarrays|if type=="array" then .[] else . end|gron'
