
diff_txt2json() {
	#grep '^[+-]' | tail -n +3
	grep '^[+-]{' |
	sed -e 's/^\(.\)\(.*\)$/["\1", \2]/g'
}

jsondiff() {
	if [ $# -lt 2 ]; then
		echo >&2 "Missing argument"
		return 1
	fi
	local f1="$1" f2="$2";shift 2
	diff -u "$@" \
		<(json_flat_sorted < "$f1") \
		<(json_flat_sorted < "$f2") \
	| diff_txt2json
}
