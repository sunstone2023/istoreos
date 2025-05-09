
type 'board_name' >/dev/null 2>/dev/null || . /lib/functions.sh

export_ota_url() {
	local board="$(board_name)"
	case "$board" in
	hlink,h28k|\
	linkfog,ala2|\
	radxa,e20c|\
	radxa,e52c|\
	radxa,e54c|\
	easepi,ars4|\
	lyt,t68m)
		export -n OTA_URL_BASE="https://fw0.koolcenter.com/iStoreOS-22.03/${board##*,}"
		;;
	easepi,r1)
		export -n OTA_URL_BASE="https://fw0.koolcenter.com/iStoreOS-22.03/easepi-r1"
		;;
	easepi,r1-lite)
		export -n OTA_URL_BASE="https://fw0.koolcenter.com/iStoreOS-22.03/easepi-r1-lite"
		;;
	fastrhino,r66s|\
	fastrhino,r68s)
		export -n OTA_URL_BASE="https://fw0.koolcenter.com/iStoreOS-22.03/r6xs"
		;;
	friendlyelec,nanopi-r3s)
		export -n OTA_URL_BASE="https://fw0.koolcenter.com/iStoreOS-22.03/r3s"
		;;
	friendlyelec,nanopi-r5c|\
	friendlyelec,nanopi-r5s-c1|\
	friendlyelec,nanopi-r5s)
		export -n OTA_URL_BASE="https://fw0.koolcenter.com/iStoreOS-22.03/r5s"
		;;
	friendlyelec,nanopi-r6s|\
	friendlyelec,nanopi-r6c)
		export -n OTA_URL_BASE="https://fw0.koolcenter.com/iStoreOS-22.03/r6s"
		;;
	firefly,rk3568-roc-pc)
		export -n OTA_URL_BASE="https://fw0.koolcenter.com/iStoreOS-22.03/station-p2"
		;;
	hinlink,opc-h66k|\
	hinlink,opc-h68k|\
	hinlink,opc-h69k)
		export -n OTA_URL_BASE="https://fw0.koolcenter.com/iStoreOS-22.03/h6xk"
		;;
	hinlink,h88k-*|\
	hinlink,h88k)
		export -n OTA_URL_BASE="https://fw0.koolcenter.com/iStoreOS-22.03/h88k"
		;;
	*)
		return 1
		;;
	esac
}
