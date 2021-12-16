
diff_txt2json() {
	#grep '^[+-]' | tail -n +3
	grep '^[+-]{' |
	sed -e 's/^\(.\)\(.*\)$/["\1", \2]/g'
}

jsondiff() {
	local s=''
	while [ $# -gt 0 ]; do
		case "$1" in
		(-s|--slurp|--ndjson) s='-s';;
		(--) shift;break;;
		(--help) echo >&2 "Usage: jsondiff [-s|--slurp|--ndjson] <jsonfile1> <jsonfile2>";return 0;;
		(-*) echo >&2 "invalid option $1"; return 1;;
		(*) break;;
		esac
		shift
	done
	if [ $# -lt 2 ]; then
		echo >&2 "Missing argument"
		return 1
	fi
	local f1="$1" f2="$2";shift 2
	diff -u "$@" \
		<(json_flat_sorted $s < "$f1") \
		<(json_flat_sorted $s < "$f2") \
	| diff_txt2json
}
