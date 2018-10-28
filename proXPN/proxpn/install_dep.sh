#!/bin/bash
echo "#!/bin/bash" > remove_dep.sh
deps=`ldd /opt/proxpn/platforms/libqxcb.so | grep -i "not found" | grep -i -v qt5 | awk '{print $1}' | sed 's/\(^.*\)\.so.*$/\1/'`
for dep in $deps
do
	pkg=`apt-cache search $dep | grep -v dev | grep -v dbg | awk '{print $1}'`
	echo "installing $pkg"
	apt-get -y install $pkg
	echo "apt-get -y remove $pkg" >> remove_dep.sh
done
chmod u+x remove_dep.sh

