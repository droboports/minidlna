#!/usr/bin/env sh
#
# MiniDLNA service

# import DroboApps framework functions
. /etc/service.subr

framework_version="2.1"
name="minidlna"
version="1.1.5"
description="MiniDLNA is a simple media server software, fully compliant with DLNA/UPnP-AV clients"
depends=""
webui="WebUI"

prog_dir="$(dirname "$(realpath "${0}")")"
daemon="${prog_dir}/sbin/minidlnad"
conffile="${prog_dir}/etc/minidlna.conf"
autofile="${prog_dir}/etc/minidlna.auto"
tmp_dir="/tmp/DroboApps/${name}"
pidfile="${tmp_dir}/pid.txt"
logfile="${tmp_dir}/log.txt"
statusfile="${tmp_dir}/status.txt"
errorfile="${tmp_dir}/error.txt"

shares_conf="/mnt/DroboFS/System/DNAS/configs/shares.conf"
shares_dir="/mnt/DroboFS/Shares"
rescan=""

# backwards compatibility
if [ -z "${FRAMEWORK_VERSION:-}" ]; then
  framework_version="2.0"
  . "${prog_dir}/libexec/service.subr"
fi

# returns 0 if the shares have changed, 1 if the shares remained the same
_load_shares() {
  local share_count
  local share_name

  cp "${conffile}.default" "${autofile}.tmp"
  share_count=$("${prog_dir}/libexec/xmllint" --xpath "count(//Share)" "${shares_conf}")
  if [ ${share_count} -eq 0 ]; then
    echo "No shares found."
  else
    echo "Found ${share_count} shares."
    for i in $(/usr/bin/seq 1 ${share_count}); do
      share_name=$("${prog_dir}/libexec/xmllint" --xpath "//Share[${i}]/ShareName/text()" "${shares_conf}")
      echo "media_dir=AVP,${shares_dir}/${share_name}" >> "${autofile}.tmp"
    done
  fi

  if ! diff -q "${autofile}.tmp" "${autofile}"; then
    mv "${autofile}.tmp" "${autofile}"
    return 0
  else
    rm -f "${autofile}.tmp"
    return 1
  fi
}

is_running() {
  killall -q -0 minidlnad
}

start() {
  local _serial
  local _conf
  if [ ! -f "${conffile}" ] && [ ! -f "${autofile}" ] && _load_shares; then
    rescan="-R"
  fi
  if [ -f "${prog_dir}/host_uid.txt" ]; then
    _serial=$(cat "${prog_dir}/host_uid.txt")
  else
    _serial=$(cat "/sys/devices/dri_dnas_primary/dnas_adp_1/driver/serial")
  fi
  if [ -f "${conffile}" ]; then
    _conf="${conffile}"
  else
    _conf="${autofile}"
  fi
  "${daemon}" -f "${_conf}" -s "${_serial}" -P "${pidfile}" ${rescan}
}

stop() {
  killall -q minidlnad
}

force_stop() {
  killall -q -9 minidlnad
}

reload() {
  if [ ! -f "${conffile}" ] && _load_shares; then
    echo "New shares detected, rescanning."
    while is_running "${pidfile}" "${daemon}"; do
      stop || true
      sleep 1
    done
    rescan="-R"
    start
  fi
}

# boilerplate
if [ ! -d "${tmp_dir}" ]; then mkdir -p "${tmp_dir}"; fi
exec 3>&1 4>&2 1>> "${logfile}" 2>&1
STDOUT=">&3"
STDERR=">&4"
echo "$(date +"%Y-%m-%d %H-%M-%S"):" "${0}" "${@}"
set -o errexit  # exit on uncaught error code
set -o nounset  # exit on unset variable
set -o xtrace   # enable script tracing

main "${@}"
