#!/usr/bin/env bash
cd $(dirname $0)

if [ ! "$XDG_CONFIG_HOME" ]; then
   export XDG_CONFIG_HOME=$HOME/.config
fi

if hash vlc 2>/dev/null; then
	./Stremio-runtime . $@
else
	# WARNING: this doesn't guarantee anything since we still need the deps of all the vlc plugins
	# so maybe consider removing the bundled vlc from stremio entirely
	LD_PRELOAD="./WCjs/vlc/lib/libvlc.so.5.5.0 ./WCjs/vlc/lib/libvlccore.so.8.0.0" ./Stremio-runtime . $@
fi
