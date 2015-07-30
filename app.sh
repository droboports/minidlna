### ZLIB ###
_build_zlib() {
local VERSION="1.2.8"
local FOLDER="zlib-${VERSION}"
local FILE="${FOLDER}.tar.gz"
local URL="http://zlib.net/${FILE}"

_download_tgz "${FILE}" "${URL}" "${FOLDER}"
pushd "target/${FOLDER}"
./configure --prefix="${DEPS}" --libdir="${DEST}/lib" --shared
make
make install
rm -v "${DEST}/lib/libz.a"
popd
}

### LIBUUID ###
_build_libuuid() {
local VERSION="1.42.13"
local FOLDER="e2fsprogs-libs-${VERSION}"
local FILE="${FOLDER}.tar.gz"
local URL="http://sourceforge.net/projects/e2fsprogs/files/e2fsprogs/v${VERSION}/${FILE}"

_download_tgz "${FILE}" "${URL}" "${FOLDER}"
pushd "target/${FOLDER}"
./configure --host="${HOST}" --prefix="${DEPS}" --libdir="${DEST}/lib" --enable-elf-shlibs --disable-quota
cd lib/uuid
make -j1
make install
rm -vf "${DEST}/lib/libuuid.a"
popd
}

### SQLITE ###
_build_sqlite() {
local VERSION="3081101"
local FOLDER="sqlite-autoconf-${VERSION}"
local FILE="${FOLDER}.tar.gz"
local URL="http://sqlite.org/$(date +%Y)/${FILE}"

_download_tgz "${FILE}" "${URL}" "${FOLDER}"
pushd "target/${FOLDER}"
./configure --host="${HOST}" --prefix="${DEPS}" --libdir="${DEST}/lib" --disable-static
make
make install
mkdir -p "${DEST}/libexec"
cp -vfa "${DEPS}/bin/sqlite3" "${DEST}/libexec/"
popd
}

### LIBEXIF ###
_build_libexif() {
local VERSION="0.6.21"
local FOLDER="libexif-${VERSION}"
local FILE="${FOLDER}.tar.gz"
local URL="http://sourceforge.net/projects/libexif/files/libexif/${VERSION}/${FILE}"

_download_tgz "${FILE}" "${URL}" "${FOLDER}"
pushd "target/${FOLDER}"
./configure --host="${HOST}" --prefix="${DEPS}" --libdir="${DEST}/lib" --disable-static
make
make install
popd
}

### LIBJPEG ###
_build_libjpeg() {
local VERSION="9a"
local FOLDER="jpeg-${VERSION}"
local FILE="jpegsrc.v${VERSION}.tar.gz"
local URL="http://www.ijg.org/files/${FILE}"

_download_tgz "${FILE}" "${URL}" "${FOLDER}"
pushd "target/${FOLDER}"
./configure --host="${HOST}" --prefix="${DEPS}" --libdir="${DEST}/lib" --disable-static --enable-maxmem=8
make
make install
popd
}

### LIBID3TAG ###
_build_libid3tag() {
local VERSION="0.15.1b"
local FOLDER="libid3tag-${VERSION}"
local FILE="${FOLDER}.tar.gz"
local URL="http://sourceforge.net/projects/mad/files/libid3tag/${VERSION}/${FILE}"

_download_tgz "${FILE}" "${URL}" "${FOLDER}"
pushd "target/${FOLDER}"
./configure --host="${HOST}" --prefix="${DEPS}" --libdir="${DEST}/lib" --disable-static --enable-maxmem=8
make
make install
popd
}

### LIBOGG ###
_build_libogg() {
local VERSION="1.3.2"
local FOLDER="libogg-${VERSION}"
local FILE="${FOLDER}.tar.gz"
local URL="http://downloads.xiph.org/releases/ogg/${FILE}"

_download_tgz "${FILE}" "${URL}" "${FOLDER}"
pushd "target/${FOLDER}"
./configure --host="${HOST}" --prefix="${DEPS}" --libdir="${DEST}/lib" --disable-static
make
make install
popd
}

### LIBVORBIS ###
_build_libvorbis() {
local VERSION="1.3.5"
local FOLDER="libvorbis-${VERSION}"
local FILE="${FOLDER}.tar.gz"
local URL="http://downloads.xiph.org/releases/vorbis/${FILE}"

_download_tgz "${FILE}" "${URL}" "${FOLDER}"
pushd "target/${FOLDER}"
./configure --host="${HOST}" --prefix="${DEPS}" --libdir="${DEST}/lib" --disable-static
make
make install
popd
}

### FLAC ###
_build_flac() {
local VERSION="1.3.1"
local FOLDER="flac-${VERSION}"
local FILE="${FOLDER}.tar.xz"
local URL="http://sourceforge.net/projects/flac/files/flac-src/${FILE}"

_download_xz "${FILE}" "${URL}" "${FOLDER}"
pushd "target/${FOLDER}"
./configure --host="${HOST}" --prefix="${DEPS}" --libdir="${DEST}/lib" --disable-static
make
make install
popd
}

### FFMPEG ###
_build_ffmpeg() {
local VERSION="2.7.2"
local FOLDER="ffmpeg-${VERSION}"
local FILE="${FOLDER}.tar.gz"
local URL="http://www.ffmpeg.org/releases/${FILE}"

_download_tgz "${FILE}" "${URL}" "${FOLDER}"
pushd "target/${FOLDER}"
./configure --enable-cross-compile --cross-prefix="${HOST}-" --prefix="${DEPS}" --libdir="${DEST}/lib" --shlibdir="${DEST}/lib" --arch="arm" --target-os=linux --enable-shared --disable-static --enable-rpath --enable-small --enable-zlib --disable-debug --disable-programs
make
make install
popd
}

### MINIDLNA ###
_build_minidlna() {
# sudo apt-get install gettext
local VERSION="1.1.4"
local FOLDER="minidlna-${VERSION}"
local FILE="${FOLDER}.tar.gz"
local URL="http://sourceforge.net/projects/minidlna/files/minidlna/${VERSION}/${FILE}"

_download_tgz "${FILE}" "${URL}" "${FOLDER}"
cp "src/icons.c" "target/${FOLDER}"
pushd "target/${FOLDER}"
./configure --host="${HOST}" --prefix="${DEST}"
make -j1
make install
#$STRIP -s -R .comment -R .note -R .note.ABI-tag "${DEST}/sbin/minidlnad"
popd
}

_build() {
  _build_zlib
  _build_libuuid
  _build_sqlite
  _build_libexif
  _build_libjpeg
  _build_libid3tag
  _build_libogg
  _build_libvorbis
  _build_flac
  _build_ffmpeg
  _build_minidlna
  _package
}
