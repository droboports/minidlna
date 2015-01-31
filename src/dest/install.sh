#!/usr/bin/env sh
#
# Transmission install script

prog_dir="$(dirname $(realpath ${0}))"
name="$(basename ${prog_dir})"
logfile="/tmp/DroboApps/${name}/install.log"

# script hardening
set -o errexit  # exit on uncaught error code
set -o nounset  # exit on unset variable

# ensure log folder exists
if ! grep -q ^tmpfs /proc/mounts; then mount -t tmpfs tmpfs /tmp; fi
logfolder="$(dirname ${logfile})"
if [[ ! -d "${logfolder}" ]]; then mkdir -p "${logfolder}"; fi

# redirect all output to logfile
exec 3>&1 1>> "${logfile}" 2>&1

# log current date, time, and invocation parameters
echo $(date +"%Y-%m-%d %H-%M-%S"): ${0} ${@}

# enable script tracing
set -o xtrace

# copy default configuration files
if [[ -n "$(find "${prog_dir}/etc" -maxdepth 1 -name "*.default")" ]]; then
  for deffile in ${prog_dir}/etc/*.default; do
    basefile="${prog_dir}/etc/$(basename ${deffile} .default)"
    if [ ! -f "${basefile}" ]; then
      cp -v "${deffile}" "${basefile}"
    fi
  done
fi
