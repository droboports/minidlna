# minidlna

This is a set of scripts to package a DroboApp from scratch, i.e., download sources, unpackage, compile, install, and package in a TGZ file. The `master` branch contains the Drobo5N version, the `drobofs` branch contains the DroboFS version.

## I just want to install the DroboApp, what do I do?

Check the [releases](https://github.com/droboports/minidlna/releases) page. If there are no releases available, then you have to compile.

## How to compile

First make sure that you have a [working cross-compiling VM](https://github.com/droboports/droboports.github.io/wiki/Setting-up-a-VM).

Log in the VM, pick a temporary folder (e.g., `~/build`), and then do:

```
git clone https://github.com/droboports/minidlna.git
cd minidlna
./build.sh
```

Each invocation creates a log file with all the generated output.

* `./build.sh distclean` removes everything, including downloaded files.
* `./build.sh clean` removes everything but downloaded files.
* `./build.sh package` repackages the DroboApp, without recompiling.

## Sources

* zlib: http://zlib.net/
* libuuid: http://e2fsprogs.sourceforge.net/
* sqlite: http://www.sqlite.org/
* libexif: http://libexif.sourceforge.net/
* libjpeg: http://www.ijg.org/
* libid3tag: http://www.underbit.com/products/mad/
* libogg: http://www.xiph.org/ogg/
* libvorbis: http://xiph.org/vorbis/
* libflac: http://flac.sourceforge.net/
* ffmpeg: http://www.ffmpeg.org/
* minidlna: http://sourceforge.net/projects/minidlna/

<sub>**Disclaimer**</sub>

<sub><sub>Drobo, DroboShare, Drobo FS, Drobo 5N, DRI and all related trademarks are the property of [Data Robotics, Inc](http://www.drobo.com/). This site is not affiliated, endorsed or supported by DRI in any way. The use of information and software provided on this website may be used at your own risk. The information and software available on this website are provided as-is without any warranty or guarantee. By visiting this website you agree that: (1) We take no liability under any circumstance or legal theory for any DroboApp, software, error, omissions, loss of data or damage of any kind related to your use or exposure to any information provided on this site; (2) All software are made “AS AVAILABLE” and “AS IS” without any warranty or guarantee. All express and implied warranties are disclaimed. Some states do not allow limitations of incidental or consequential damages or on how long an implied warranty lasts, so the above may not apply to you.</sub></sub>
