#!/usr/bin/env bash
# This script was auto generated using the code-cleanup package http://forumubuntusoftware.info/viewtopic.php?f=23&t=9480
# ==============================================================================
# title			:conky-builder
# description	:Builds a Conky skeleton based on hardware detected.
# author		:theemahn <theemahn@ultimateedition.info>
# date			:3/06/2018
# version		:1.30
# usage			:conky-builder --help
# manual		:man conky-builder
# notes			:See change-log below for further information.
# ==============================================================================
# Change-log:

# 1.0	initial public release

# 1.1	internal release

# 1.2	internal release

# 1.3	internal release

# 1.4	Added distribution detection, added resolution detection
#	to set fonts and sizes.

# 1.05	Added version compliance for deb based releases
#	Added better networking detection / wireless support.
#	Added memory output to compare against pae based kernels.
#	Added 800 X 600 support, how did I miss this resolution?
#	Added initial support for Ultimate Player (dynamically)
#	Added support for all network interface detection / Active.
#	Never have I seen this implementation.  I try to think outside of
#	the box please report issues.
#	Added support for Ultimate Edition 2.6.4 and 3.1 detection
#	Added dynamic Wireless support.
#	Added CPU Temp / Fan speeds also dynamic.

# 1.06	Added Radio tray to the mix
#	Initiated the anti-cron job mode of thinking, execi can be executed
#	w/o the need for a cron job.  Let's base this on the end users CPU.
#	Added no Internet means do not propagate - includes wireless.
#	The same across the board when I am done and hopefully will not
#	require a cron job.64bit

# 1.07	Initiated real-time information, across issues I have set forth.
#	Set CPU Temp to display info real-time based on end users processor. A
#	single core CPU will not be updated as fast as a quad for example
#	please see timeslices in my code.
#	Set fan speed accordingly as above.

# 1.08	Split the Conky builder for Ultimate Player info
#	May integrate the info as a function later.
#	Added progress bar for current playing track.
#	All info for Ultimate Player is now real-time.

# 1.09	First initial deb based release

# 1.10	Internal release for Ultimate Edition 3.01
#	Fixed improper spacing when closing Ultimate Player.

# 1.11	Fixed improper CPU detection on some Intel based processors.
#	Began writing weather location / detection via users IP address.
#	the above will be a fairly difficult procedure. Query to a API driven
#	Geo-positioning map to obtain location based on zip code, once obtained
#	a query to another API   driven site noaa.gov.  Will require no user
#	interaction.

# 1.12	Added support for 12.04 precise (Ultimate Edition 3.4 & 3.5) based releases.

# 1.13	Corrected colors to be only 1 color for now, easier reading on most wallpapers.
#	Will eventually write it to detect theme and set colors appropriately.

# 1.14	Added GPU and Main-board temp detection routines.
#	Added initial dual monitor detection / setup routine.
#	Added ppp0 network detection to the mix, thanks Seedo Eldho Paul
#	Added Hard-disk temperature detection, this was a rough one to sift
#	though and match with the drives.

# 1.15	Internal release to Ultimate Edition 3.5
#	Fixed Garbling of GPU / CPU Temp
#	Adjusted Colors to coincide with Ultimate Edition 3.5 Theme
#	Removed Lua usage. Thanks Mr. Breeg and Goliath for testing

# 1.16	Set colors in CLI so errors etc. Stand out.
#	Added additional distribution detection routines (debugging currently)
#	No sense in having to re-write conky builder every-time I build a new OS.
#	Display album art if Ultimate Player is Jamming.
#	Major code clean up, I am a slob ;)
#	Updated distribution logo
#	Mass updates to resolution detection routine. Simple once again becomes
#	complex thanks to addition of the artwork from Ultimate Player.

# 1.17	Adjusted output of information to comply with screen width.
#	Detection of USB drives - no output of temperature.
#	Detection of NAS drives - no output of temperature.
#	Added 1280 X 800 resolution; thanks, tanmay.01
#	Adjusted Temp detection routines let's not waste space.
#	Dual monitors now displayed @0 pixels from the top.
#	Took debugging into my own hands on temps.
#	Smartly built displaying of temp info into columns.
#	If no Swap. No Swap info reported in Conky. Save precious screen resources.
#	Reduced top processes to 3.
#	Adjusted diskio activity and network activity bars to coincide in length.

# 1.18	Added NFS based Network Attached Storage detection.

# 1.19	Ran code-clean and bashdepends on this script, dependencies adjusted.

# 1.20	Added Video card detection
#	Changed colors to coincide with colors of Ultimate Edition 3.4 series
#	Added Raid array detection

# 1.21	Point to point protocol issue gone?  Thanks again Seedo
# 	Implemented enhanced color / bar graphs.
#	Added 1366 X 768 resolution, thanks again Seedo

# 1.22	Check for install of hddtemp. Set as recommended in deb not required
#	Fixed errors spitting out when checking temp of USB / NAS drives.
#	Adjusted colors for Ultimate Edition 4.0
#	Adjusted mountpoints to strip username if applicable (12.10+ changed this)
#	Added check for SUID for hddtemp
#	Added Hard drive size detection & total filesystem capacity output info
#	Added Detecttion of root filesystem

# 1.23	Added support for 1920X2280 Dual monitor vertical orientation.
#	Ran code through bash script maker. Now has help and version system.

# 1.24	Added support for 1920X2400 Dual monitor vertical orientation.
#	Added better WiFi support (multiple adapters simotaneously supported).
#	Added full Ultimate Player detection.
# 	Ran software through code-cleanup package.
#	Added eyecandy functions.
#	Adjusted dependancies conky-all | conky-std, lm-sensors now recomended
#
# 1.25	Added initial support for 4K monitors.
#
# 1.26	Added support for Pithos (Pandora Client)
#		Added support for Clementine Media Player
#		Set recomends in control to recomend media | players
#		Cleaned up code.
#
# 1.27	Initiated NFS / Samba mounted hardware detection
#
# 1.28	Set compatability with KDE 5 (Ultimate Edition 5.7)
#
# 1.29  Added better detection of NAS (Network Attached Storage)
#
# 1.30  Added better detection of hard mounted USB devices.
#       Better detection of CPU Resonation on Multi-core CPUS.
#       Updated Media player detection.
#       Added GPU Temp detection / population
#       Added CPU Temp detection / population
#             
# =============== End Change-log ===================== #
# set -x <<- Enable for Debugging purposes

# Modify the below information to correlate with the software you are designing.
PROGNAME="conky-builder"
PROGRAMMER="theemahn"
BUILDDATE="03/06/2018"
VERSION="1.30"
WEBSITE="os-builder.com"
AUTHOR="TheeMahn"
EMAIL="<$AUTHOR@$WEBSITE>"
APPNAME="Conky Builder"

# Varibles
# Retrieve the number of lines the TTY has.
LINEZ=$(tput lines)

# Retrieve the number of columns the TTY has.
COLUMNZ=$(tput cols)

# Optional graphical notification, see if user has it installed.
NOTIFY=$(which notify-send)

# Optional sound notification, see if user has it installed.
SOUND=$(which canberra-gtk-play)

# Internal variable used for doing eyecandy
declare -i TT
TT=0
declare -i CALC
CALC=0
declare -i RR
RR=0

# Info for determining current user to possibly compare against later
IUSER=${SUDO_USER:-$USER}
IHOME=/home/$IUSER

# set colors so errors etc. stand out.
txtred=$(tput setaf 1)
txtgrn=$(tput setaf 2)
bldblu=$(tput setaf 4)
#txtwht=$(tput setaf 7)
BRIGHT=$(tput bold)
#BOLD=$(tput smso)
txtrst='\e[0m'    # Text Reset
DEBUG=$(echo "$*" | grep -i "debug")
#Common Functions to make programming easier, dont need them delete them.
# Calculate percentage usage: x=$(Percent 2 3 2) ; echo $x # gives 66.66
# The first 2 / 3, the last is the scale ie 2 decimal places
function Percent () {
	echo "scale = $3; $1 * 100 / $2" | bc
}

CommandLineInterpreter() {
	#echo -e "${bldgrn}Number of switches passed: $#"
	for var in "$@"
	do
		array_counter=$((array_counter + 1))

		#Encapsulate "Switch $array_counter: $var"
	done
}

# Set a timer to display duration ##
# Usage:  Timer [start|stop]
Timer() {
	# Debugging switches... Uncomment to see output: 03/30/2016 added as an
	# Optional switch - useful for me and the end user.
	if [[ "$DEBUG" ]]; then
		shopt -s expand_aliases
		# shellcheck disable=SC2128
		Center "DEBUG INFORMATION: ${FUNCNAME}"
		# a bug has been filed against shellcheck: https://github.com/koalaman/shellcheck/issues/634
		echo -en "Caller: "
		caller
	fi
    	Tcmd="${1^^}"

    case "$Tcmd" in
        START) _StartSecs=$(date +%s)
            ;;
        STOP) _StopSecs=$(date +%s)
                [[ ! $_StartSecs ]] && Error "[Internal Error] Timer did not record a start time." && return
                ((_DiffSecs=_StopSecs-_StartSecs))
                TimeLapse=$(date -u -d@"$_DiffSecs" +'%-Hh%-Mm%-Ss')
                Encapsulate "Timer: $TimeLapse"
            ;;
        *) Error "[Internal Error] ${FUNCNAME}: Unknown arg '$Tcmd'"
            ;;
    esac
	TTIMEM="$TimeLapse"
}

# Future implementation - log all chroot results.
LogResults() {
	#Encapsulate "Initiating Logging function... in $PWD"
	for EACH in "${LOGFILEZ[@]}"
	do
		#Encapsulate "Checking for $EACH"
		if [[ -f "edit/var/log/$EACH" ]]; then
			#Encapsulate "Found $EACH Logging to ${LOG_FILE}"
			cat "edit/var/log/$EACH" >> ${LOG_FILE}
			Encapsulate "LOG FILE: $EACH" >> "extract-cd/README.TXT"
			Encapsulate "========" >> "extract-cd/README.TXT"
			cat "edit/var/log/$EACH" >> "extract-cd/README.TXT"
		else
			Encapsulate "No error(s) to back up."
			#Encapsulate "Non-existant."
		fi
	done
	Encapsulate "$PROGNAME --modify if you wish to make adjustments to the O/S."
	FullBar
}

# Download various packages showing progression...
Download() {
	local url="$1"
	echo -n "    "
	wget --progress=dot "$url" 2>&1 | grep --line-buffered "%" | \
	sed -u -e "s,\.,,g" | awk '{printf("\b\b\b\b%4s", $2)}'
	echo -ne "\b\b\b\b"
	Encapsulate "Done."
}

# Dump data to the screen in pretty columns.
Columnize() {
	# Columnize is an internally called function exclusively.
	# EXAMPLE
	# -t to shove through the column titles we will count the number of switches and
	# calculate spacing eventually.
	if [[ "$1" == "-t" ]]; then
		#echo -e "${bldgrn}Number of switches passed: $#"
		for ARG in "$@"
		do
			array_counter=$((array_counter + 1))
			if [[ "$array_counter" -gt 2 ]]; then
				#Encapsulate "Switch $array_counter: $ARG"
				ARGUMENTS[$array_counter]="$ARG"
				tLen="${#ARGUMENTS[$array_counter]}"
				if [[ $tLen -ge $WIDEST ]]; then
					WIDEST="$tLen"
				fi
				#Encapsulate "Length of ${ARGUMENTS[$array_counter]} is $tLen"
			fi
			#Encapsulate "The widest passed varible is $WIDEST"
		done
	else
		#echo -e "${bldgrn}Number of switches passed: $#"
		for ARG in "$@"
		do
			array_counter=$((array_counter + 1))
			if [[ "$array_counter" -gt 1 ]]; then
				#Encapsulate "Switch $array_counter: $ARG"
				ARGUMENTS[$array_counter]="$ARG"
				tLen="${#ARGUMENTS[$array_counter]}"
				if [[ "$tLen" -ge "$WIDEST" ]]; then
					WIDEST="$tLen"
				fi
				#Encapsulate "Length of ${ARGUMENTS[$array_counter]} is $tLen"
			fi
			#Encapsulate "The widest passed varible is $WIDEST"
		done
	fi
	#Encapsulate "#: $# VARS: $*"
	#LONGESTLENGTH="${#2}"
	#Encapsulate "Length of $2 is $LONGESTLENGTH"
	#echo $COLUMNZ
	MAINS=$(echo "scale=2; $COLUMNZ-30" | bc)
	MAINS=${MAINS%.*}
	#echo $MAINS
	MAINS=$((MAINS - 2))
	MAINS=$((MAINS / 4))
	#echo $MAINS
	if [[ "$1" = '-t' ]]; then
		#"#" "DEV" "VENDOR" "LABEL" "TYPE" "SIZE"
		printf "%-0s %-16s %-7s %-16s %-7s %-3s %-13s %-3s %-16s %-1s\n" "▒" "$2" "$3" "$4" "$5" "$6" "$7" "$8"
	else
		#MAINS=$(expr $MAINS / 2)
		printf "%-0s %-16s %-7s %-16s %-7s %-3s %-13s %-3s %-16s %-1s\n" "▒" "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8"
	fi
}

Error() {
	echo -en "${txtred}"
	#FullBar
	Center "$1" "--ERROR"
	#echo -en "${txtred}"
	#FullBar
	echo -en "${txtrst}"
}

# for outputting to X-11 screen a notification of completion and playing sound.
# The sound file is from the "Optional" ultimate-edition-sound-theme
Notification() {
	# Is X11 running?
	X="$DISPLAY"
	
#	X=$(xdpyinfo -display :0) >/dev/null
	if [[ "$DEBUG" ]]; then
		echo "DEBUG: $X"
	fi
	# Does the user have the optional UE Sound scheme installed?
	if [[ -f "/usr/share/sounds/Ultimate Edition Sound Scheme/stereo/itisdone.wav" ]]; then
		WAVE="1"
	fi
	# Is the user in an X11 GUI environment and have notification OSD installed?
	if [[ "$X" && "$NOTIFY" ]]; then
		notify-send "$APPNAME" "$1" -i /usr/share/ultimate_edition/logo.png -t 5000
	fi
	# Does the user have pre-requisites? If so, break out the Cylon voice.
	if [[ "$SOUND" && "$WAVE" ]]; then
		canberra-gtk-play --file "/usr/share/sounds/Ultimate Edition Sound Scheme/stereo/itisdone.wav" 2>/dev/null
	fi
	# Display message in terminal unconditionally
	Encapsulate "$1"
}

# Usage: Eye Candy "Message"
# Example: Eye Candy "Repostorm $REPOVERSION is entering extraction mode."
# ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
# ▒ Repostorm 1.7.7 is entering extraction mode. ▒
# ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
EyeCandy() {
	# Verify a message has been sent to this otherwise do squat.

	STP="$1"
	if [[ "$STP" ]]; then
		STRLEN="${#STP}"
		((STRLEN=STRLEN + 3))
		GREPPED=$(echo "$STP" | grep -E '\e')
		if [[ "$GREPPED" ]]; then
			((STRLEN=STRLEN - 13))
		fi
		RR=0; while [ "$RR" -le "$STRLEN" ]; do echo -n "▒"; ((RR=RR+1)); done; echo;
		echo -e "${bldblu}▒${txtgrn} $STP ${bldblu}▒"
		RR=0; while [ "$RR" -le "$STRLEN" ]; do echo -n "▒"; ((RR=RR+1)); done; echo;
	fi
}

# Usage: Encapsulate
# Encapsulate "Repostorm 1.8.7 is entering extraction mode."
# Example: ▒ Repostorm 1.8.7 is entering extraction mode. ▒
Encapsulate() {
	# Verify a message has been sent to this otherwise do squat.
	# Example: Encapsulate ('Repostorm $REPOVERSION is entering extraction mode.')
	# ▒ Repostorm 1.7.7 is entering extraction mode.                       ▒

	STP="$1"
	if [[ "$STP" ]]; then
		STRLEN="${#STP}"
		((STRLEN=STRLEN + 3))
		((DISTANCE=COLUMNZ - STRLEN))
		GREPPED=$(echo "$STP" | grep -E '\e')
		if [[ "$GREPPED" ]]; then
			((STRLEN=STRLEN - 13))
		fi
		echo -en "${BRIGHT}${bldblu}▒ ${BRIGHT}${txtgrn}$STP"
		RR=0; while [ "$RR" -lt "$DISTANCE" ]; do echo -n " "; ((RR=RR+1)); done; echo "${BRIGHT}${bldblu}▒";
	fi
}

# Center data passed to on screen
Center() {
	STP="$1"
	ERROR="$2"
	if [[ "$STP" ]]; then
		STRLEN="${#STP}"
		((CENTER=STRLEN / 2 ))
		#CENTER=CENTER-1
		((TCENTER=COLUMNZ / 2 ))
		#TCENTER=TCENTER-1
		((DISTANCE=TCENTER - CENTER))
		((DISTANCE=DISTANCE - 2))
		if ! [[ "$ERROR" ]]; then
			echo -en "${txtrst}"
		else
			echo -en "${txtred}"
		fi
		RR=0; while [ "$RR" -lt "$DISTANCE" ]; do echo -n "${BRIGHT}${bldblu}▒"; ((RR=RR+1)); done;
		echo -en "${BRIGHT}${txtgrn} $STP "
		if ! [[ "$ERROR" ]]; then
			echo -en "${txtrst}"
		else
			echo -en "${txtred}"
		fi
		TT=0; while [ "$TT" -lt "$DISTANCE" ]; do echo -n "${BRIGHT}${bldblu}▒"; ((TT=TT+1)); done;
		((CALC=RR + TT + STRLEN + 2))
		if [[ "$CALC" -lt "$COLUMNZ" ]]; then
			while [ "$CALC" -lt "$COLUMNZ" ]; do echo -n "${BRIGHT}${bldblu}▒"; ((CALC=CALC+1)); done; echo;
		fi
	fi
	# Encapsulate "STRING LEN: $STRLEN CENTER: $CENTER TOTAL CNTER: $TCENTER RR:$RR TT:$TT COLUMNZ: $COLUMNZ CALC: $CALC DISTANCE: $DISTANCE"
	echo -en "${txtrst}"
}

# Draws a bar across the screen based on screen size detected (columnz)
FullBar() {
	RR=1; while [ "$RR" -le "$COLUMNZ" ]; do echo -n "${BRIGHT}${bldblu}▒"; ((RR=RR+1)); done; echo;
}

# Dump version information and exit function
VersionDump() {
	# Debugging switches... Uncomment to see output: 03/30/2016 added as an
	# Optional switch - useful for me and the end user.
	AMOUNT=0
	if [[ "$DEBUG" ]]; then
		Center "DEBUG INFORMATION: $FUNCNAME"
		for EACH in "$@"
		do
			((AMOUNT ++))
			Encapsulate "$AMOUNT:$EACH "
		done
		echo -en "Caller [LINE] / APP: "
		caller
		FullBar
		echo -en "${txtrst}"
	fi

	GREPIT=$(echo "$*" | grep "suppress")
	if ! [[ "$GREPIT" ]]; then
		Center "$APPNAME ($PROGNAME) $VERSION, $BUILDDATE"
		Encapsulate "GNU $PROGNAME home page: <http://$WEBSITE/>."
		Encapsulate "E-mail bug reports to: $EMAIL."
		Encapsulate "Be sure to include the word $PROGNAME somewhere in the Subject: field."
		FullBar
	else
		Encapsulate "$APPNAME ($PROGNAME) $VERSION, $BUILDDATE"
		Encapsulate "GNU $PROGNAME home page: <http://$WEBSITE/>."
		Encapsulate "E-mail bug reports to: $EMAIL."
		Encapsulate "Be sure to include the word $PROGNAME somewhere in the Subject: field."
	fi
}
# Begin programming here.
#set Base, hi-light color & header please adjust colors in hex and font to your liking
#http://simple.wikipedia.org/wiki/List_of_colors
BASE='${color #ffffff}${font Liberation:style=normal:pixelsize='$FONTSIZE'}' #Atomic Tangerine
HILIGHT='${color #ffff00}${font Liberation:style=normal:pixelsize='$FONTSIZE'}' #Yellow
HEADER='${color #00ffff}${font Liberation:style=Bold:pixelsize='$FONTSIZE'}' #Cyan
BAR='${color #ffd700}' #Gold

############### You Should not have to edit anything below #############

if [[ -f /usr/bin/ultimate-player ]]; then
	ULTIMATEPLAYER='/usr/bin/ultimate-player'
	UPSCRIPT='~.config/Ultimate-Player/UP.sh'
fi

# Dual monitors?
declare -i Dual

# Set hard-coded variables
ISHDDTEMP=$(which hddtemp)
ISHDDEXEC="NO"
SENSORS=$(which sensors)

function Main(){
	VersionDump
	# Set default Operating System in case of failure
	OS='Ultimate Edition'

	# See if user has hddtemp installed, and more importantly has proper permissions
	# to execute it via user non-root (SUID).  If not inform the user how to fix it.
	# This stops: /dev/sda3: open: Permission denied errors.
	FullBar
	if [[ "$ISHDDTEMP" ]]; then
		SSTATS=$(stat -c %A $ISHDDTEMP | sed 's/...\(.\).\+/\1/')
		if [[ "$SSTATS" == "s" ]]; then
			echo -e "${txtgrn}Congradulations, hddtemp is properly configured. Temperature information will be populated.${txtrst}"
			ISHDDEXEC="YES"
		fi
	else
		echo -e "${txtred}Warning: hddtemp is not installed, sudo apt-get install hddtemp${txtrst}"
	fi

	if [[ "$ISHDDEXEC" == "NO" && "$ISHDDTEMP" ]]; then
		echo -e "${txtred}Error: SUID for hddtemp is not set, sudo dpkg-reconfigure hddtemp${txtrst}"
	fi
	Center "Operating system information"

	#Detect code-base / Distribution
	OS=$(lsb_release -i | sed -n 's/^Distributor ID:[ \t]*\(.*\)/\1/p')
	DISTREL=$(lsb_release -r | sed -n 's/^Release:[ \t]*\(.*\)/\1/p')
	DISTDESC=$(lsb_release -d | sed -n 's/^Description:[ \t]*\(.*\)/\1/p')
	CODEBASE=$(cat /etc/lsb-release | grep -i 'DISTRIB_CODENAME=' | sed "s/DISTRIB_CODENAME=//g")

	Encapsulate "Codebase detected: $CODEBASE"

	Encapsulate "$DISTDESC"
	# detect if release is odd or even.
	EVENODD=$(dpkg -l | grep -i "kubuntu-desktop")

	if [[ "$EVENODD" != "" ]]; then
		Encapsulate "Kubuntu base: detected - odd number release"
	else
		Encapsulate "Kubuntu base not detected - even number release"
	fi


	Encapsulate "Distro detected: "
	#TESTING ABOVE
	DISTRO="$OS $DISTREL"
	OS=$DISTRO
	Encapsulate "$DISTRO"

	# Attempt to advance the script.  No sense having the user edit this script
	# if we can obtain the information without user intervention.
	Center "Hardware Information"
	res=$(xrandr -q | grep 'current' | cut -d"," -f2 | sed 's/current//g' | sed 's/ //g')

	# set defaults in case user has an unknown resolution. Better too small then too
	# large
	GRAPHWIDTH=320 #size of box in pixels
	FONTSIZE=8 #default font size
	SZE=64
	DUAL=0
	AHW=52
	AARTY=44
	GRAPHWIDTH=260
	FONTSIZE=7

	Encapsulate "Detected current resolution: $res"

	case "$res" in
		3840x2160)
		DUAL=1
		AHW=110
		AARTY=180
		GRAPHWIDTH=840
		FONTSIZE=24
		Encapsulate "4K monitor detected. Taking full advantage of extra screen resources."
		Encapsulate "Setting font size to $FONTSIZE and graph width to $GRAPHWIDTH" ;;
		3840x1200)
		# Tested known good
		DUAL=1
		AHW=76
		AARTY=76
		GRAPHWIDTH=440
		FONTSIZE=12
		Encapsulate "Dual monitors detected. Taking full advantage of extra screen resources."
		Encapsulate "Setting font size to $FONTSIZE and graph width to $GRAPHWIDTH" ;;
		3840x1080)
		# Tested known good
		DUAL=1
		AHW=88
		AARTY=98
		GRAPHWIDTH=640
		FONTSIZE=16
		Encapsulate "Dual monitors detected. Taking advantage of extra screen resources."
		Encapsulate "Setting font size to $FONTSIZE and graph width to $GRAPHWIDTH" ;;
		3200x1200)
		DUAL=1
		AHW=88
		AARTY=98
		GRAPHWIDTH=640
		FONTSIZE=16
		Encapsulate "Dual monitors detected. Taking advantage of extra screen resources."
		Encapsulate "Setting font size to $FONTSIZE and graph width to $GRAPHWIDTH" ;;
		3200x1024)
		# Tested known good
		DUAL=1
		AHW=90
		AARTY=80
		GRAPHWIDTH=520
		FONTSIZE=14
		Encapsulate "Dual monitors detected. Taking advantage of extra screen resources."
		Encapsulate "Setting font size to $FONTSIZE and graph width to $GRAPHWIDTH" ;;
		3360x900)
		# Tested known good
		DUAL=1
		AHW=78
		AARTY=74
		GRAPHWIDTH=480
		FONTSIZE=12
		Encapsulate "Dual monitors detected. Taking advantage of extra screen resources."
		Encapsulate "Setting font size to $FONTSIZE and graph width to $GRAPHWIDTH" ;;
		3200x960)
		# Tested known good
		DUAL=1
		AHW=78
		AARTY=74
		GRAPHWIDTH=480
		FONTSIZE=12
		Encapsulate "Dual monitors detected. Taking advantage of extra screen resources."
		Encapsulate "Setting font size to $FONTSIZE and graph width to $GRAPHWIDTH" ;;
		2560x1440)
		DUAL=1
		AHW=78
		AARTY=74
		GRAPHWIDTH=480
		FONTSIZE=12
		Encapsulate "Dual monitors detected. Taking advantage of extra screen resources."
		Encapsulate "Setting font size to $FONTSIZE and graph width to $GRAPHWIDTH" ;;
		1920x2400)
		DUAL=1
		AHW=78
		AARTY=74
		GRAPHWIDTH=480
		FONTSIZE=12
		Encapsulate "Dual monitors detected. Taking advantage of extra screen resources."
		Encapsulate "Setting font size to $FONTSIZE and graph width to $GRAPHWIDTH" ;;
		1920x2280)
		DUAL=1
		AHW=78
		AARTY=74
		GRAPHWIDTH=480
		FONTSIZE=12
		Encapsulate "Dual monitors detected. Taking advantage of extra screen resources."
		Encapsulate "Setting font size to $FONTSIZE and graph width to $GRAPHWIDTH" ;;
		1920x1200)
		# Tested; known Good.
		AHW=84
		AARTY=84
		GRAPHWIDTH=600
		FONTSIZE=14
		Encapsulate "Setting font size to $FONTSIZE and graph width to $GRAPHWIDTH" ;;
		1920x1080)
		# Tested; known Good.
		AHW=69
		AARTY=90
		GRAPHWIDTH=600
		FONTSIZE=14
		Encapsulate "Setting font size to $FONTSIZE and graph width to $GRAPHWIDTH" ;;
		1600x1200)
		# Tested; known Good.
		AHW=84
		AARTY=84
		GRAPHWIDTH=550
		FONTSIZE=14
		Encapsulate "Setting font size to $FONTSIZE and graph width to $GRAPHWIDTH" ;;
		1680x1050)
		# Tested; known Good.
		AHW=84
		AARTY=84
		GRAPHWIDTH=550
		FONTSIZE=14
		Encapsulate "Setting font size to $FONTSIZE and graph width to $GRAPHWIDTH" ;;
		1680x945)
		# Tested; known Good.
		AHW=84
		AARTY=84
		GRAPHWIDTH=550
		FONTSIZE=14
		Encapsulate "Setting font size to $FONTSIZE and graph width to $GRAPHWIDTH" ;;
		1440x900)
		# Tested known good
		AHW=66
		AARTY=75
		GRAPHWIDTH=420
		FONTSIZE=12
		Encapsulate "Setting font size to $FONTSIZE and graph width to $GRAPHWIDTH" ;;
		1400x1050)
		# unknown
		AHW=75
		AARTY=70
		GRAPHWIDTH=420
		FONTSIZE=11
		Encapsulate "Setting font size to $FONTSIZE and graph width to $GRAPHWIDTH" ;;
		1366x768)
		# Tested known good
		AHW=75
		AARTY=70
		GRAPHWIDTH=420
		FONTSIZE=11
		Encapsulate "Setting font size to $FONTSIZE and graph width to $GRAPHWIDTH" ;;
		1280x1024)
		# Tested known good
		AHW=75
		AARTY=71
		GRAPHWIDTH=400
		FONTSIZE=11
		Encapsulate "Setting font size to $FONTSIZE and graph width to $GRAPHWIDTH" ;;
		1280x960)
		# Tested known good
		AHW=75
		AARTY=71
		GRAPHWIDTH=400
		FONTSIZE=11
		Encapsulate "Setting font size to $FONTSIZE and graph width to $GRAPHWIDTH" ;;
		1280x720)
		# Tested known good
		AHW=64
		AARTY=56
		GRAPHWIDTH=340
		FONTSIZE=9
		Encapsulate "Setting font size to $FONTSIZE and graph width to $GRAPHWIDTH" ;;
		1152x864)
		# Tested known good
		AHW=64
		AARTY=56
		GRAPHWIDTH=340
		FONTSIZE=9
		Encapsulate "Setting font size to $FONTSIZE and graph width to $GRAPHWIDTH" ;;
		1024x768)
		# Tested known good
		AHW=64
		AARTY=56
		GRAPHWIDTH=340
		FONTSIZE=9
		Encapsulate "Setting font size to $FONTSIZE and graph width to $GRAPHWIDTH" ;;
		800x600)
		# Tested known good
		AHW=52
		AARTY=44
		GRAPHWIDTH=260
		FONTSIZE=7
		Encapsulate "Setting font size to $FONTSIZE and graph width to $GRAPHWIDTH" ;;
		832x624)
		# Tested known good
		AHW=52
		AARTY=48
		GRAPHWIDTH=300
		FONTSIZE=8
		Encapsulate "Setting font size to $FONTSIZE and graph width to $GRAPHWIDTH" ;;
		720x400)
		GRAPHWIDTH=180
		FONTSIZE=6
		Encapsulate "Setting font size to $FONTSIZE and graph width to $GRAPHWIDTH" ;;
		640x480)
		GRAPHWIDTH=180
		FONTSIZE=6
		Encapsulate "Setting font size to $FONTSIZE and graph width to $GRAPHWIDTH" ;;
		*)
		GRAPHWIDTH=320
		FONTSIZE=12
		Error "Resolution not programmed defaulting, please report detected resolution\n above to <theemahn@ultimateedition.info>" ;;
	esac

	#set Base, hi-light color & header please adjust colors in hex and font to your liking
	#http://simple.wikipedia.org/wiki/List_of_colors
	BASE='${color #ffffff}${font Liberation:style=normal:pixelsize='$FONTSIZE'}' #Atomic Tangerine
	HILIGHT='${color #ffff00}${font Liberation:style=normal:pixelsize='$FONTSIZE'}' #Yellow
	HEADER='${color #00ffff}${font Liberation:style=Bold:pixelsize='$FONTSIZE'}' #Cyan
	BAR='${color #ffd700}' #Gold

	############### You Should not have to edit anything below #############

	#Calculate v offset based on Fonts / pixelsize
	VOFF=$((FONTSIZE+6))
	ALEFT=$((FONTSIZE/4))
	INDENT=$((FONTSIZE/2))
	BARZ=$((GRAPHWIDTH/2))
	BOFFSET=$((FONTSIZE/3))
	TICON=$((FONTSIZE/5))
	BPER=$((GRAPHWIDTH/100*75))
	SBAR=$((GRAPHWIDTH/100*20))
	LOGO=$((FONTSIZE*2))
	SZE=$((LOGO*2))
	LOGO=$((LOGO - 5))
	BPER=$((BPER - 10))
	AARTX=$((GRAPHWIDTH - $AHW))
	#Encapsulate "Logo Size: $SZE"

	#Get CPU model
	RESONATION=$(lscpu | grep -i 'cpu max Mhz' | cut -d ":" -f2)
	PROC=$(cat /proc/cpuinfo | grep -m1 'model name' | sed -e 's/.*: //' | uniq)
	Encapsulate "Processor: $PROC resonating at $RESONATION Mhz"

	#check Architecture set 32 bit default
	ARCHITECTURE="32 Bit"

	#
	# Check for x86_64 (Test 1) - some O/S's use the -i switch
	#
	CARCH=$(uname -i | grep -i "x86_64")
	if [ "$CARCH" == "x86_64" ]; then
		ARCHITECTURE="64 Bit"
	fi

	#
	# Check for x86_64 (Test 2) - some OSs (ie. Gentoo) return Processor manufacturer
	#rather than architecture with "uname -i"
	#
	if [ "`uname -a|grep x86_64`" != "" ]; then
		ARCHITECTURE="64 Bit"
	fi

	# Report to user
	Encapsulate "$ARCHITECTURE O/S detected."

	# Count number of processor cores
	CORES=1 #Set default
	CORES=$(cat /proc/cpuinfo | grep "processor" | sed '/model/d' | wc -l)

	# Lets's not choke the end users CPU if they have limited resources.
	TIMESLICES=$(( 12 / $CORES))

	# Report findings
	Encapsulate "$CORES CPU core(s) Detected."
	Encapsulate "Update interval set: $TIMESLICES seconds"
	declare -i MEMTOTAL
	declare -i SWAPTOTAL
	MEMTOTAL=$(cat /proc/meminfo | grep -i "MemTotal" | cut -d":" -f2 | cut -d "k" -f1)
	GIGS=$(free -m -h | grep -i "mem:" | awk '{print $2}')
	SWAPTOTAL=$(cat /proc/meminfo | grep -i "SwapTotal" | sed "s/ //g" | cut -d ':' -f2 | cut -d "k" -f1)
	SWAPGIG=$(free -m -h | grep -i "swap" | awk '{print $2}')

	#Convert to comma seperated values...Memory
	if [[ "$MEMTOTAL" && "$GIGS" ]]; then
		MEMSIZE=$(printf "%'.3f\n" "$MEMTOTAL")
		MEMORY=$(echo "$MEMSIZE" | cut -d. -f1)
		Encapsulate "Memory: $MEMORY,000 bytes ($GIGS)"
	else
		Error "Cannot retrieve memory information..."
	fi

	#Convert to comma seperated values...Swap space
	if [[ "$SWAPTOTAL" && "$SWAPGIG" ]]; then
		MEMSIZE=$(printf "%'.3f\n" "$SWAPTOTAL")
		SWAPMEMORY=$(echo "$MEMSIZE" | cut -d. -f1)
		Encapsulate "Swap Space: $SWAPMEMORY,000 bytes ($SWAPGIG)"
	else
		Error "No Swap? Cannot retrieve Swap information, conky will not be populated."
	fi

	FullBar
	Center "Networking Information"
	#Advance network detection to perfection scan all interfaces:
	shopt -s nullglob
	declare -a INTERFACES=()

	ACTIVE=""
	if [[ -d "/sys/class/net/" ]]; then
		CURRENT="$PWD"
		cd "/sys/class/net/" || exit 1;
		INTERFACES=(*/)
		for EACH in "${INTERFACES[@]}"
		do
			ACT=$(cat "/sys/class/net/${EACH%/}/operstate")
			if [[ "$ACT" == "up" ]]; then
				ACTIVE="${EACH%/}"
				Encapsulate "Interface: ${EACH%/} is $ACT"
			else
				Encapsulate "Interface: ${EACH%/} is $ACT"
			fi
		done
	else
		Error "No standard interface detected.  Point to Point Protocol?"
	fi
	# Current Seedo work...  If the folder exists most likely it is the
	# active connection set it as such.  Point to Point Protocol evidently
	# does not do states. up / down etc.
	if [[ -d "/sys/class/net/ppp0/" && "$ACTIVE" == "" ]]; then
		ACTIVE="ppp0"
	fi
	if [[ "$ACTIVE" ]]; then
		Encapsulate "Active Monitoring Connection:"
		Encapsulate "$ACTIVE"
	else
		Error "No active network interface found."
	fi
	FullBar
	#Detect "Active" network and propigate Network Xfer bar
	#ACTIVE=`ifconfig | grep -B 1 inet | head -1 | awk '{print $1}'`
	#Wireless?
	#wlan=$(cat /sys/class/net/wlan0/operstate)
	#enet=$(cat /sys/class/net/eth0/operstate)

	#Hardline?
	#if [[ $enet == 'up' ]]; then
	#$ACTIVE='eth0'
	#fi

	#Wireless
	#if [[ $wlan == 'up' ]]; then
	#ACTIVE='wlan0'
	#fi

	#Dual monitors?
	if [[ "$DUAL" == 0 ]]; then
		GAPX=15
		GAPY=30
	else
		GAPX=15
		GAPY=0
	fi

	#Create conky skelaton
	echo '#Use XFT?
	use_xft yes
	xftfont Liberation:style=normal:pixelsize='$FONTSIZE'
	xftalpha 0.8
	text_buffer_size 2048

	# Update interval in seconds
	update_interval 1

	# This is the number of times Conky will update before quitting.
	# Set to zero to run forever.
	total_run_times 0

	# Create own window instead of using desktop (required in nautilus)
	own_window yes
	own_window_transparent yes
	own_window_type normal
	own_window_class conky-semi
	own_window_class normal
	own_window yes
	own_window_type normal
	own_window_transparent yes
	own_window_hints undecorated,below,skip_taskbar,skip_pager
	own_window_argb_visual yes
	own_window_argb_value 100

	#own_window_hints undecorated,below,sticky,skip_taskbar,skip_pager

	# Use double buffering (reduces flicker, may not work for everyone)
	double_buffer yes

	# Minimum size of text area -adjust if you would like to user smaller fonts etc.
	minimum_size '$GRAPHWIDTH' 0
	maximum_width '$GRAPHWIDTH'
	max_user_text 16384
	default_bar_size '$BPER' 5

	# Draw shades?
	draw_shades no
	default_color 0a3f6d #ffffff
	# Draw outlines?
	draw_outline no

	# Draw borders around text
	draw_borders no

	# Stippled borders?
	stippled_borders 0

	# border width
	border_width 1

	# Text alignment, other possible values are commented
	#alignment top_left
	alignment top_right
	#alignment bottom_left
	#alignment bottom_right

	# Gap between borders of screen and text
	# same thing as passing -x at command line
	gap_x '$GAPX'
	gap_y '$GAPY'

	#Default weather to fahrenheit, please change the below if you prefer celcius.
	temperature_unit fahrenheit

	# -- Lua Load -- # - removed in conky builder > 1.15
	#lua_load ~/.draw_bg.lua
	#lua_draw_hook_pre draw_bg

	# -- Album art fix -- #
	imlib_cache_size 0
	' > ~/.conkyrc

	echo 'TEXT' >> ~/.conkyrc

	# Begin system info output
	echo '${image /usr/share/ultimate_edition/logo.png -p '$BARZ','$LOGO' -s '$SZE'x'$SZE'}'$HEADER'SYSTEM ${hr 2 }'$BASE >> ~/.conkyrc
	echo '${alignr}'$OS' - ${alignr}$kernel '$ARCHITECTURE >> ~/.conkyrc
	echo '${alignr}'$USER'@$nodename' >> ~/.conkyrc
	echo -n '${goto '$INDENT'}${voffset '$TICON'}${font StyleBats:pixelsize='$FONTSIZE'}k${font}${voffset -'$ALEFT'}${goto '$VOFF'}${font}Processes: '$HILIGHT'$processes' >> ~/.conkyrc
	echo $BASE'${alignr}${voffset '$TICON'}${font StyleBats:pixelsize='$FONTSIZE'}q${font}Uptime: '$HILIGHT'${uptime}' >> ~/.conkyrc

	# Ultimate Player running? If not; no info is populated on Conky.
	echo '${if_running ultimate-player}'$HEADER'ULTIMATE PLAYER ${hr 2 }'$BASE'${image ~/.config/Ultimate-Player/Current.art -p '$AARTX','$AARTY' -s '$AHW'x'$AHW'}' >> ~/.conkyrc
	echo '${voffset 2}${font Poky:pixelsize='$FONTSIZE'}k${font}${goto '$VOFF'}${voffset -'$ALEFT'}${font}Artist: '$HILIGHT'${execi '$TIMESLICES' .config/Ultimate-Player/UP.sh ultimate artist}' >> ~/.conkyrc
	echo $BASE'${font}${voffset 2}${font Poky:pixelsize='$FONTSIZE'}k${font}${goto '$VOFF'}${voffset -'$ALEFT'}${font}Title: '$HILIGHT'${execi '$TIMESLICES' .config/Ultimate-Player/UP.sh ultimate title}' >> ~/.conkyrc
	echo $BASE'${font}${voffset 2}${font Poky:pixelsize='$FONTSIZE'}k${font}${goto '$VOFF'}${voffset -'$ALEFT'}${font}Album: '$HILIGHT'${execi '$TIMESLICES' .config/Ultimate-Player/UP.sh ultimate album}' >> ~/.conkyrc
	echo '${execibar '$TIMESLICES' .config/Ultimate-Player/UP.sh ultimate progress}${else}${endif}' >> ~/.conkyrc

	# Radio Tray running? In not; no info is populated on Conky.
	echo '${if_running radiotray}'$HEADER'RADIO TRAY ${hr 2 }'$BASE >> ~/.conkyrc
	echo '${voffset 2}${font Poky:pixelsize='$FONTSIZE'}k${goto '$VOFF'}${voffset -'$ALEFT'}${font}Playing: '$HILIGHT '${execi '$TIMESLICES' .config/Ultimate-Player/UP.sh rplay}${else}${voffset -23}${endif}' >> ~/.conkyrc

	# Pithos running? In not; no info is populated on Conky.
	echo '${if_running pithos}'$HEADER'PANDORA (PITHOS) ${hr 2 }''${execi '$TIMESLICES' .config/Ultimate-Player/UP.sh pithos}'$BASE'${image ~/.config/Ultimate-Player/Current.art -p '$AARTX','$AARTY' -s '$AHW'x'$AHW'}' >> ~/.conkyrc
	echo '${voffset 2}${font Poky:pixelsize='$FONTSIZE'}k${font}${goto '$VOFF'}${voffset -'$ALEFT'}${font}Artist: '$HILIGHT'${execi '$TIMESLICES' .config/Ultimate-Player/UP.sh pithos artist}' >> ~/.conkyrc
	echo $BASE'${font}${voffset 2}${font Poky:pixelsize='$FONTSIZE'}k${font}${goto '$VOFF'}${voffset -'$ALEFT'}${font}Title: '$HILIGHT'${execi '$TIMESLICES' .config/Ultimate-Player/UP.sh pithos title}' >> ~/.conkyrc
	echo $BASE'${font}${voffset 2}${font Poky:pixelsize='$FONTSIZE'}k${font}${goto '$VOFF'}${voffset -'$ALEFT'}${font}Album: '$HILIGHT'${execi '$TIMESLICES' .config/Ultimate-Player/UP.sh pithos album}${else}${voffset -21}${endif}' >> ~/.conkyrc

	# Clementine running? In not; no info is populated on Conky.
	echo '${if_running clementine}'$HEADER'CLEMENTINE ${hr 2 }''${execi '$TIMESLICES' .config/Ultimate-Player/UP.sh clementine}'$BASE'${image ~/.config/Ultimate-Player/Current.art -p '$AARTX','$AARTY' -s '$AHW'x'$AHW'}' >> ~/.conkyrc
	echo '${voffset 2}${font Poky:pixelsize='$FONTSIZE'}k${font}${goto '$VOFF'}${voffset -'$ALEFT'}${font}Artist: '$HILIGHT'${execi '$TIMESLICES' .config/Ultimate-Player/UP.sh clementine artist}' >> ~/.conkyrc
	echo $BASE'${font}${voffset 2}${font Poky:pixelsize='$FONTSIZE'}k${font}${goto '$VOFF'}${voffset -'$ALEFT'}${font}Title: '$HILIGHT'${execi '$TIMESLICES' .config/Ultimate-Player/UP.sh clementine title}' >> ~/.conkyrc
	echo $BASE'${font}${voffset 2}${font Poky:pixelsize='$FONTSIZE'}k${font}${goto '$VOFF'}${voffset -'$ALEFT'}${font}Album: '$HILIGHT'${execi '$TIMESLICES' .config/Ultimate-Player/UP.sh clementine album}${endif}' >> ~/.conkyrc
	#echo '${execibar '$TIMESLICES' .config/Ultimate-Player/UP.sh clementine progress}${else}${voffset -21}${endif}' >> ~/.conkyrc

	#Core(s) info
	echo $HEADER'CPU${hr 2 }'$BASE >> ~/.conkyrc
    
	

	# Hit sensors to see if temperature(s) are detected / reported.
	Encapsulate "SCANNING MOTHERBOARD FOR TEMP SENSOR(S)..."
	if [[ $SENSORS ]]; then
		CPUTEMP=$(sensors -f | grep -n "temp1" | sed -n 1p | cut -d":" -f3 | cut -d "+" -f2 | awk -F"+" "{print $2}" | cut -d"(" -f1 2> /dev/null)
		GPUTEMP=$(sensors -f | grep -n "temp1" | sed -n 2p | cut -d":" -f3 | cut -d "+" -f2 | awk -F"+" "{print $2}" | cut -d"(" -f1 2> /dev/null)
		VIDCARD=$(glxinfo | grep -m 1 'renderer string' | sed 's/OpenGL renderer string: //g' | awk '{print $1, $2, $3, $4, $5, $6}' 2> /dev/null)
		MBTEMP=$(sensors -f | grep -m 1 "MB Temp" | cut -d: -f2| sed "s/ //g" | sed "s/+//g" | cut -d"(" -f1 2> /dev/null)
		FANSPEED=$(sensors -f | grep -m 1 "CPU Fan Speed"| cut -d: -f2 | sed "s/ //g" | sed "s/+//g" | cut -d"(" -f1 2> /dev/null)
		Center "Motherboard Sensors"
		echo -e "${undgrn}OBJECT\t\tDISCOVERED\t\tSENSOR${txtrst}"
        FullBar
		EVEN=0
		echo -n $BASE >> ~/.conkyrc
		#CPUTEMP="" #set for debugging purposes
		if [[ "$CPUTEMP" != "" ]]; then
            echo -n '${goto '$INDENT'}${voffset '$TICON'}${font Stylebats:pixelsize='$FONTSIZE'}A${font}${voffset -'$ALEFT'}${goto '$VOFF'}${font}${goto '$VOFF'}'$PROC'${goto '$INDENT'}${font StyleBats:pixelsize='$FONTSIZE'}A${goto '$VOFF'}${alignr}${font}CPU TEMP: '$HILIGHT' ${alignr}${execi 0 sensors -f | grep -n "temp1" | sed -n 1p | cut -d":" -f3 | cut -d "+" -f2 | awk -F"+" "{print $2}" | cut -d"(" -f1}' >> ~/.conkyrc
			EVEN=1
			echo -e "CPU\t\tYES\t\t\t$CPUTEMP"
		else
			echo -e "CPU\t\tNO\t\t\t${bldred} N/A${txtrst}"
			EVEN=0
		fi
        echo "$BASE" >> ~/.conkyrc
        echo '${goto '$INDENT'}${font StyleBats:pixelsize='$FONTSIZE'}A${voffset -'$ALEFT'}${goto '$VOFF'}${font}CPU Usage: '$HILIGHT' ${freq}MHz X '$CORES'${alignr}${cpu cpu0}% '$BAR' ${cpubar cpu0 '$INDENT','$SBAR'}' >> ~/.conkyrc
        
		#FANSPEED="" #set for debugging purposes

		if [[ "$FANSPEED" != "" ]]; then
			if [[ "$EVEN" == "0" ]]; then
				echo -n $BASE'${goto '$INDENT'}${font StyleBats:pixelsize='$FONTSIZE'}F${voffset -'$ALEFT'}${goto '$VOFF'}${font}Fan speed: '$HILIGHT >> ~/.conkyrc
				echo -n '${execi '$TIMESLICES' sensors -f| grep -m -1 "CPU Fan Speed"|cut -d: -f2|sed "s/ //g"|sed "s/+//g" | cut -d"(" -f1}' >> ~/.conkyrc
				echo -e "FANSPEED\tYES\t\t\t$FANSPEED"
				EVEN=1 # Set switch so next detected can be set on the same line.
			else
				echo -n $BASE'Fan Speed: '$HILIGHT >> ~/.conkyrc
				echo '${execi '$TIMESLICES' sensors -f | grep -m 1 "CPU Fan Speed"|cut -d: -f2|sed "s/ //g"|sed "s/+//g" | cut -d"(" -f1}' >> ~/.conkyrc
				echo -e "FANSPEED\tYES\t\t\t$FANSPEED"
				EVEN=0 # End of the line doe no use the -n with echo above.
			fi
		else
			echo -e "FANSPEED\tNO\t\t\t${bldred} N/A${txtrst}"
		fi

		#GPUTEMP="" #set for debugging purposes
		#GPU TEMP?
		if [[ "$GPUTEMP" != "" ]]; then
			if [[ "$EVEN" == "0" ]]; then
				if [[ "$VIDCARD" == "" ]]; then
					echo -n $BASE'${goto '$INDENT'}${font StyleBats:pixelsize='$FONTSIZE'}Y${voffset -'$ALEFT'}${goto '$VOFF'}${font}GPU Temp: '$HILIGHT >> ~/.conkyrc
					echo -n '${alignr}${font}GPU TEMP:'$HILIGHT'${execi '$TIMESLICES' sensors -f | grep -n "temp1" | sed -n 2p | cut -d":" -f3 | cut -d "+" -f2 | awk -F"+" "{print $2}" | cut -d"(" -f1}' >> ~/.conkyrc
					echo -e "GPU\t\tYES\t\t\t$GPUTEMP"
					EVEN=1
				else
					echo -n $BASE'${goto '$INDENT'}${font StyleBats:pixelsize='$FONTSIZE'}Y${voffset -'$ALEFT'}${goto '$VOFF'}${font}GPU: '$VIDCARD': '$HILIGHT >> ~/.conkyrc
					echo -n '${alignr}${font}GPU TEMP:'$HILIGHT'${execi '$TIMESLICES' sensors -f | grep -n "temp1" | sed -n 2p | cut -d":" -f3 | cut -d "+" -f2 | awk -F"+" "{print $2}" | cut -d"(" -f1}' >> ~/.conkyrc
					echo -e "GPU\t\tYES\t\t\t$GPUTEMP"
					EVEN=1
				fi
			else
				if [[ "$VIDCARD" == "" ]]; then
					echo -n '${font}${alignr}GPU Temp: '$HILIGHT >> ~/.conkyrc
					echo '${execi '$TIMESLICES' sensors -f | grep -n "temp1" | sed -n 2p | cut -d":" -f3 | cut -d "+" -f2 | awk -F"+" "{print $2}" | cut -d"(" -f1}' >> ~/.conkyrc
					echo -e "GPU\t\tYES\t\t\t$GPUTEMP"
					EVEN=0
				else                    
					echo -n $BASE'${goto '$INDENT'}${voffset '$TICON'}${font Stylebats:pixelsize='$FONTSIZE'}A${font}${voffset -'$ALEFT'}${goto '$VOFF'}${font}${goto '$VOFF'}'$VIDCARD'${goto '$INDENT'}${font StyleBats:pixelsize='$FONTSIZE'}A${goto '$VOFF'}${alignr}${font}GPU TEMP: '$HILIGHT' ${alignr}${execi '$TIMESLICES' sensors -f | grep -n "temp1" | sed -n 2p | cut -d":" -f3 | cut -d "+" -f2 | awk -F"+" "{print $2}" | cut -d"(" -f1}' >> ~/.conkyrc
                    echo "$BASE" >> ~/.conkyrc
					echo -e $VIDCARD"\t\tYES\t\t\t$GPUTEMP"
					EVEN=0
				fi

			fi
		else
			echo -e "GPU\t\tNO\t\t\t${bldred} N/A${txtrst}"
		fi

		#MBTEMP="" #set for debugging purposes
		#Main-board Temp?
		if [[ "$MBTEMP" != "" ]]
			then
			if [[ "$EVEN" == "0" ]]; then
				echo -n $BASE'${goto '$INDENT'}${font StyleBats:pixelsize='$FONTSIZE'}F${voffset -'$ALEFT'}${goto '$VOFF'}${font}MB Temp: '$HILIGHT >> ~/.conkyrc
				echo '${execi '$TIMESLICES' sensors -f|grep -m 1 "MB Temp" | cut -d: -f2| sed "s/ //g" | sed "s/+//g" | cut -d"(" -f1}' >> ~/.conkyrc
				echo -e "MAIN-BOARD\tYES\t\t\t$MBTEMP"
				EVEN=1
			else
				echo -n $BASE'${font}${alignr}MB Temp: '$HILIGHT >> ~/.conkyrc
				echo '${execi '$TIMESLICES' sensors -f|grep -m 1 "MB Temp" | cut -d: -f2| sed "s/ //g" | sed "s/+//g" | cut -d"(" -f1}' >> ~/.conkyrc
				echo -e "MAIN-BOARD\tYES\t\t\t$MBTEMP"
				EVEN=0
			fi
		else
			echo -e "MAIN-BOARD\tNO\t\t\t${bldred} N/A${txtrst}"
		fi

		# Close out TEMPS with a line.
		echo $HEADER'${hr 2}'$BASE >> ~/.conkyrc
		# Sensors is NOT installed, inform enduser.
	else
		Error "Error: Sensors package is not installed, sudo apt-get install lm-sensors."
		# Closes of need / discovery of temp sensors package
	fi

	# Create a cpubar for each core
	COUNTER=0
	while [  "$COUNTER" != "$CORES" ]; do
		COUNTER=$((COUNTER + 1))
		echo '${goto '$INDENT'}${voffset '$TICON'}${font StyleBats:pixelsize='$FONTSIZE'}A${font}${voffset -'$ALEFT'}${goto '$VOFF'}${font}Core '$COUNTER':' $HILIGHT'${cpu cpu'$COUNTER'}% '$BAR'${alignr}${cpubar cpu'$COUNTER' '$INDENT','$BPER'}'$BASE >> ~/.conkyrc
	done

	# Output total memory / usage.
	echo $HEADER'RAM${hr 2 }'$BASE >> ~/.conkyrc
	echo -n $BASE'${voffset 2}${font VariShapes Solid:pixelsize='$FONTSIZE'}N'$BASE'Useage: '$HILIGHT'$mem / $memmax ${alignr}'$HILIGHT'$memperc% '$BAR'${membar '$INDENT','$SBAR'}' >> ~/.conkyrc

	# Swap check - no sense in display the info if the user does not have any swap.
	if [[ "$SWAPTOTAL" != "0" ]]; then
		echo '' >> ~/.conkyrc
		echo $BASE'${goto '$INDENT'}${voffset '$TICON'}${font Stylebats:pixelsize='$FONTSIZE'}j${font}${voffset -'$ALEFT'}${goto '$VOFF'}'$BASE'Swap: '$HILIGHT'$swap/$swapmax${alignr}$swapperc% '$BAR'${swapbar '$INDENT','$SBAR'}' >> ~/.conkyrc
	else
		echo "" >> ~/.conkyrc
	fi

	# Top Processes / Ram Hogs
	echo $BASE'${goto '$INDENT'}${voffset '$TICON'}${font Poky:pixelsize='$FONTSIZE'}a${font}${voffset -'$ALEFT'}${goto '$VOFF'}'$BASE'${goto '$VOFF'}Highest: ${alignr}CPU     RAM
	${goto '$VOFF'}${voffset -5.5}'$HILIGHT'${hr 2}
	'$HILIGHT'${voffset -1}${goto '$VOFF'}${top name 1}${alignr}${top cpu 1}  ${top mem 1}
	${goto '$VOFF'}${top name 2}${alignr}${top cpu 2}  ${top mem 2}
	${goto '$VOFF'}${top name 3}${alignr}${top cpu 3}  ${top mem 3}' >> ~/.conkyrc

	# File-system(s)
	echo $HEADER'FILESYSTEM(s)${hr 2 }'$BASE >> ~/.conkyrc
	echo $BASE'${goto '$INDENT'}${voffset '$TICON'}${font Poky:pixelsize='$FONTSIZE'}Y${font}${voffset -'$ALEFT'}${goto '$VOFF'}'$BASE'Disk I/O: '$HILIGHT'${diskio}${alignr}'$BAR'${diskiograph '$LOGO','$BPER'}'>> ~/.conkyrc

	# Detect hard disks & create a bar for each mount point provide info to end user
	# Step one crack out the whip on the SCSI (Sata) channel.

	# HDSIZE=0 future implementation
	# TSPACE=0 future implementation

	# MANUALLY ADD RootFS to the mix, the only one guaranteed to be thier fs ;)
	MOUNTPOINT=$(df / | awk '{print $6}' | sed '1d')
	STRIPPED="RootFS"
	declare -a line=();
	line=$(df | grep -w "/" | sed "/rootfs/d" | cut -d" " -f1)
	echo "ANALYSING $EACH"
	for EACH in "${line[@]}"
	do
	HDSIZE=$(df -H "$EACH" | sed "1d" | awk '{print $2}')
	if [[ "$ISHDDTEMP" ]]; then

		# TEST 2 conditions:
		# 1. NON-EXISTANT OUTPUT IE USB HDD / Burner
		# 2. Permissions to hddtemp SUID
		# Catch erronious output, eject it to null and skip smart checks.
		TSTVAR=$(hddtemp "$line" /dev/null 2>&1 | grep -i 'Permission denied')
		if ! [[ $TSTVAR ]]; then
			TSTVAR=$(hddtemp "$line" /dev/null 2>&1 | grep -i "t have a temperature sensor.")
		fi

		# hddtemp permissions are correct and a sensor exists on current drive.
		if ! [[ "$TSTVAR" ]]; then
			HDTEMP=$(hddtemp "$line" --unit=f --numeric)
			SMART=$(echo "$HDTEMP" | grep -v "S.M.A.R.T. not available")
			SENSOR=$(echo "$HDTEMP" | grep -v "have a temperature sensor")
		fi
	fi
	done
	#TSPACE=$(expr ${TSPACE} + ${HDSIZE})

	# If Temperature was detected populate Conky as well display info to user.
	if [[ "$SMART" != "" &&  "$SENSOR" != "" ]]; then
		echo $BASE'${goto '$INDENT'}${voffset '$TICON'}${font Poky:pixelsize='$FONTSIZE'}H${font}${voffset -'$ALEFT'}${goto '$VOFF'}'$BASE$DISPMOUNTPOINT' ('$line'):${tab}'$HILIGHT'${fs_free '$MOUNTPOINT'} / ${fs_size '$MOUNTPOINT'}${alignr}${hddtemp '$HDTMP'}°F | ${fs_used_perc '$MOUNTPOINT'}% '$BAR'${fs_bar '$INDENT','$SBAR' '$MOUNTPOINT'}'$BASE >> ~/.conkyrc
	else
		echo $BASE'${goto '$INDENT'}${voffset '$TICON'}${font Poky:pixelsize='$FONTSIZE'}H${font}${voffset -'$ALEFT'}${goto '$VOFF'}'$BASE$DISPMOUNTPOINT' ('$line'):${tab}'$HILIGHT'${fs_free '$MOUNTPOINT'} / ${fs_size '$MOUNTPOINT'}${alignr}${fs_used_perc '$MOUNTPOINT'}% '$BAR'${fs_bar '$INDENT','$SBAR' '$MOUNTPOINT'}'$BASE >> ~/.conkyrc
	fi

	# display the information to end user in pretty columns
	Center "Storage Information"
	echo -en "${undgrn}"
	printf '%-15s %-24s % 1s %s\n' \
	DEVICE MOUNTPOINT HDTEMP HDSIZE
	echo -en "${txtrst}"
	printf '%-15s %-24s % 1s    %s\n' \
	"rootfs" "/" "$HDTEMP°F" "$HDSIZE"

	awk '/dev\/sd/ {print $1}' /etc/mtab | sort | while read line
	do
		MOUNTPOINT=$(df "$line" | awk '{print $6}' | sed '1d')
		DISPMOUNTPOINT=$(echo "$MOUNTPOINT" | sed "s/$USER\///g" | sed "s/\/media\///g" | sed "s/media\///g" | sed "s/\/mnt\///g")
		STRIPPED=$(echo "$MOUNTPOINT" | sed 's/\/media\///g')
		echo $MOUNTPOINT >> /tmp/mpoint.txt
		if [ "$STRIPPED" = "/" ]; then
			STRIPPED="Root"
		fi

		HDDTMP=$(echo "$line" | sed 's/[0-9]*//g')
		#Future implementation?
		HDSIZE=$(df -H "$line" | sed "1d" | awk '{print $2}')

		#See if hddtemp is installed & SUID executable, if not don't do squat
		if [[ "$ISHDDTEMP" ]]; then

			# TEST 2 conditions:
			# 1. NON-EXISTANT OUTPUT IE USB HDD / Burner
			# 2. Permissions to hddtemp SUID
			# Catch erronious output, eject it to null and skip smart checks.
			TSTVAR=$(hddtemp "$line" /dev/null 2>&1|grep 'Permission denied')
			if ! [[ "$TSTVAR" ]]; then
				TSTVAR=$(hddtemp "$line" /dev/null 2>&1 | grep -i "t have a temperature sensor.")
			fi

			# hddtemp permissions are correct and a sensor exists on current drive.
			if ! [[ "$TSTVAR" ]]; then
				HDTEMP=$(hddtemp "$line" --unit=f --numeric)
				SMART=$(echo "$HDTEMP" | grep -v "S.M.A.R.T. not available")
				SENSOR=$(echo "$HDTEMP" | grep -v "have a temperature sensor")
			fi
		fi
		#TSPACE=$(expr ${TSPACE} + ${HDSIZE})

		# If Temperature was detected populate Conky as well display info to user.
		if [[ "$SMART" != "" &&  "$SENSOR" != "" ]]; then
			printf '%-15s %-24s % 1s    %s\n' \
			"$line" "$DISPMOUNTPOINT" "$HDTEMP°F" "$HDSIZE"
			echo $BASE'${goto '$INDENT'}${voffset '$TICON'}${font Poky:pixelsize='$FONTSIZE'}H${font}${voffset -'$ALEFT'}${goto '$VOFF'}'$BASE$DISPMOUNTPOINT' ('$line'):${tab}'$HILIGHT'${fs_free '$MOUNTPOINT'} / ${fs_size '$MOUNTPOINT'}${alignr}${hddtemp '$DISPMOUNTPOINT'}°F | ${fs_used_perc '$MOUNTPOINT'}% '$BAR'${fs_bar '$INDENT','$SBAR' '$MOUNTPOINT'}'$BASE >> ~/.conkyrc
		else
			printf '%-15s %-24s % 1s     %s\n' \
			"$line" "$DISPMOUNTPOINT" "N/A" "$HDSIZE"
			echo $BASE'${goto '$INDENT'}${voffset '$TICON'}${font Poky:pixelsize='$FONTSIZE'}H${font}${voffset -'$ALEFT'}${goto '$VOFF'}'$BASE$DISPMOUNTPOINT' ('$line'):${tab}'$HILIGHT'${fs_free '$MOUNTPOINT'} / ${fs_size '$MOUNTPOINT'}${alignr}${fs_used_perc '$MOUNTPOINT'}% '$BAR'${fs_bar '$INDENT','$SBAR' '$MOUNTPOINT'}'$BASE >> ~/.conkyrc
		fi
	done;

	# Hard disks continued. HDA/B Etc.?
	awk '/dev\/hd/ {print $1}' /etc/mtab | sort | while read line
	do
		MOUNTPOINT=$(df "$line" | awk '{print $6}' | sed '1d')
		DISPMOUNTPOINT=$(echo "$MOUNTPOINT" | sed "s/$USER\///g" | sed "s/\/media\///g" | sed "s/media\///g" | sed "s/\/mnt\///g")
		STRIPPED=$(echo "$MOUNTPOINT" | sed 's/\/media\///g')
		echo $MOUNTPOINT >> /tmp/mpoint.txt

		if [[ $STRIPPED == "/" ]]; then
			STRIPPED="Root"
		fi

		# Hard Drive / USB / Partition: Set temp readings if it applies as per drive."
		HDDTMP=$(echo "$line" | sed 's/[0-9]*//g')
		#See if hddtemp is installed & SUID executable, if not don't do squat
		if [[ "$ISHDDTEMP" ]]; then

			# TEST 2 conditions:
			# 1. NON-EXISTANT OUTPUT IE USB HDD / Burner
			# 2. Permissions to hddtemp SUID
			# Catch erronious output, eject it to null and skip smart checks.
			TSTVAR=$(hddtemp "$line" /dev/null 2>&1 | grep -i "Permission denied")
			if ! [[ "$TSTVAR" ]]; then
				TSTVAR=$(hddtemp "$line" /dev/null 2>&1 | grep -i "t have a temperature sensor.")
			fi

			# hddtemp permissions are correct and a sensor exists on current drive.
			if ! [[ "$TSTVAR" ]]; then
				HDTEMP=$(hddtemp "$line" --unit=f --numeric)
				SMART=$(echo $HDTEMP | grep -v "S.M.A.R.T. not available")
				SENSOR=$(echo "$HDTEMP" | grep -v "have a temperature sensor")
			fi
		fi

		HDSIZE=$(df -H "$line" | sed "1d" | awk '{print $2}')
		HDTEMP=$(hddtemp "$line" --unit=f --numeric)
		SMART=$(echo "$HDTEMP" | grep -v "S.M.A.R.T. not available")
		SENSOR=$(echo "$HDTEMP" | grep -v "have a temperature sensor")
		#TSPACE=$(expr ${TSPACE} + ${HDSIZE})

		# If Temperature was detected populate Conky as well display info to user.
		if [[ "$SMART" != "" &&  "$SENSOR" != "" ]]; then
			printf '%-15s %-24s % 1s    %s\n' \
			"$line" "$DISPMOUNTPOINT" "$HDTEMP°F" "$HDSIZE"
			echo $BASE'${goto '$INDENT'}${voffset '$TICON'}${font Poky:pixelsize='$FONTSIZE'}H${font}${voffset -'$ALEFT'}${goto '$VOFF'}'$BASE$DISPMOUNTPOINT' ('$line'):${tab}'$HILIGHT'${fs_free '$MOUNTPOINT'} / ${fs_size '$MOUNTPOINT'}${alignr}${hddtemp '$HDTEMP'}°F | ${fs_used_perc '$MOUNTPOINT'}% '$BAR'${fs_bar '$INDENT','$SBAR' '$MOUNTPOINT'}'$BASE >> ~/.conkyrc
		else
			printf '%-15s %-24s % 1s     %s\n' \
			"$line" "$DISPMOUNTPOINT" "N/A" "$HDSIZE"
			echo $BASE'${goto '$INDENT'}${voffset '$TICON'}${font Poky:pixelsize='$FONTSIZE'}H${font}${voffset -'$ALEFT'}${goto '$VOFF'}'$BASE$DISPMOUNTPOINT' ('$line'):${tab}'$HILIGHT'${fs_free '$MOUNTPOINT'} / ${fs_size '$MOUNTPOINT'}${alignr}${fs_used_perc '$MOUNTPOINT'}% '$BAR'${fs_bar '$INDENT','$SBAR' '$MOUNTPOINT'}'$BASE >> ~/.conkyrc
		fi
	done;

	# Hard disks continued. RAID MD0 Etc.?
	awk '/dev\/md/ {print $1}' /etc/mtab | sort | while read line
	do
		MOUNTPOINT=$(df "$line" | awk '{print $6}' | sed "1d")
		DISPMOUNTPOINT=$(echo "$MOUNTPOINT" | sed "s/$USER\///g" | sed "s/\/media\///g" | sed "s/media\///g" | sed "s/\/mnt\///g")
		STRIPPED=$(echo "$MOUNTPOINT" | sed "s/\/media\///g")
		echo "$MOUNTPOINT" >> /tmp/mpoint.txt

		if [[ "$STRIPPED" == "/" ]]; then
			STRIPPED="Root"
		fi

		# Hard Drive / USB / Partition: Set temp readings if it applies as per drive."
		HDDTMP=$(echo "$line" | sed "s/[0-9]*//g")
		HDSIZE=$(df -H "$line" | sed "1d" | awk '{print $2}')
		#TSPACE=$(expr ${TSPACE} + ${HDSIZE})

		# If Temperature was detected populate Conky as well display info to user.
		printf '%-15s %-24s % 1s     %s\n' \
		"$line" "$DISPMOUNTPOINT" "N/A" $HDSIZE
		echo $BASE'${goto '$INDENT'}${voffset '$TICON'}${font Poky:pixelsize='$FONTSIZE'}H${font}${voffset -'$ALEFT'}${goto '$VOFF'}'$BASE$DISPMOUNTPOINT' ('$line'):${tab}'$HILIGHT'${fs_free '$MOUNTPOINT'} / ${fs_size '$MOUNTPOINT'}${alignr}${fs_used_perc '$MOUNTPOINT'}% '$BAR'${fs_bar '$INDENT','$SBAR' '$MOUNTPOINT'}'$BASE >> ~/.conkyrc

	done;


	# Step 2 NFS based NAS
	# or better yet write a function & eliminate a large chunk of code.
	df -h | awk '/:/ {print $1 "|" $2}' /etc/mtab | while read line
	do
        NET=$(echo "$line" | cut -d "|" -f1)
        NET="${NET##*/}"
        URL="NAS"
		MOUNTPOINT="$URL:$NET"
        MPOINT=$(echo "$line" | cut -d "|" -f2)
        FRIENDLY=$(echo "$MPOINT"  | sed "s/$USER\///g" | sed "s/\/media\///g" | sed "s/media\///g" | sed "s/\/mnt\///g")
        if [[ "$FRIENDLY" ]]; then
            MOUNTPOINT="$MPOINT"
        fi
        SIZE=$(df -h "$MPOINT" | awk '{print $2}' | sed "1d")
        #echo "DEBUGGING: NET:$NET URL:$URL LINE:$line SIZE:$SIZE FRIENDLY:$FRIENDLY"
		STRIPPED=$(echo "$MOUNTPOINT" | sed "s/\/media\///g")
		echo "$MOUNTPOINT" >> /tmp/mpoint.txt
		fout=$(echo "$line" | cut -d":" -f1)
		printf '%-15s %-24s % 1s     %s\n' \
		"$fout" "$STRIPPED" "N/A" "$SIZE"
		HDDTMP=$(echo "$line" | sed "s/[0-9]*//g")
		echo $BASE'${goto '$INDENT'}${voffset '$TICON'}${font Poky:pixelsize='$FONTSIZE'}H${font}${voffset -'$ALEFT'}${goto '$VOFF'}'$BASE$STRIPPED' ('$fout'): '$HILIGHT'${fs_free '$MOUNTPOINT'} / ${fs_size '$MOUNTPOINT'}${alignr}${fs_used_perc '$MOUNTPOINT'}% '$BAR'${fs_bar '$INDENT','$SBAR' '$MOUNTPOINT'}'$BASE >> ~/.conkyrc
	done;


	# Step 3 Burners
	awk '/dev\/sr/ {print $1}' /etc/mtab | sort | while read line
	do
		MOUNTPOINT=$(df "$line" | awk "{print $6}" | sed "1d")
		STRIPPED=$(echo "$MOUNTPOINT" | sed "s/\/media\///g")
		if [ "$STRIPPED" = "/" ]; then
			STRIPPED="Root"
		fi
		printf '%-15s %-24s %s\n' \
		"$line" "$STRIPPED" "N/A"
		HDDTMP=$(echo "$line" | sed "s/[0-9]*//g")
		echo $BASE'${goto '$INDENT'}${voffset '$TICON'}${font Poky:pixelsize='$FONTSIZE'}H${font}${voffset -'$ALEFT'}${goto '$VOFF'}'$BASE$STRIPPED' ('$line'):${tab}'$HILIGHT'${fs_free '$MOUNTPOINT'} / ${fs_size '$MOUNTPOINT'}${alignr}${fs_used_perc '$MOUNTPOINT'}% '$BAR'${fs_bar '$INDENT','$SBAR' '$MOUNTPOINT'}'$BASE >> ~/.conkyrc
	done;

	# Step 4 - Why stop there snatch up NAS(s) drives.
	awk '/\/\// {print $2}' /etc/mtab | sort | while read line
	do
		MOUNTPOINT=$(df "$line" | awk '{print $8}' | sed '1d')
		STRIPPED=$(echo "$MOUNTPOINT" | sed 's/\/media\///g')
		if [[ "$STRIPPED" == "/" ]]; then
			STRIPPED="Root"
		fi
		printf '%-15s %-24s %s\n' \
		"$line" "$STRIPPED" N/A
		# No temp detection via network do not populate TEMP.
		echo $BASE'${goto '$INDENT'}${voffset '$TICON'}${font Poky:pixelsize='$FONTSIZE'}H${font}${voffset -'$ALEFT'}${goto '$VOFF'}'$BASE$STRIPPED' ('$line'):${tab}'$HILIGHT'${fs_free '$MOUNTPOINT'} / ${fs_size '$MOUNTPOINT'}${alignr}${fs_used_perc '$MOUNTPOINT'}% '$BAR'${fs_bar '$INDENT','$SBAR' '$MOUNTPOINT'}'$BASE >> ~/.conkyrc
	done;
	FullBar
	df -H --total | grep 'total'
	# Network re-visit...
	if [[ "$ACTIVE" != "No Inet" ]];then
		echo $HEADER'ACTIVE NETWORK: '$ACTIVE'${hr 2 }'$BASE >> ~/.conkyrc >> ~/.conkyrc

		# Propagate networking information based on active connection
		echo '${voffset 2}${font VariShapes Solid:pixelsize='$FONTSIZE'}q${goto '$VOFF'}${voffset -'$ALEFT'}'$BASE'Up: '$HILIGHT'${upspeed '$ACTIVE'} '$BAR'${alignr}${upspeedgraph '$ACTIVE' '$LOGO','$BPER' ${font} '$BAR' }' >> ~/.conkyrc
		#${voffset -24}${goto '$VOFF'}Total: ${totalup '$ACTIVE'}
		echo $BASE'${voffset -'$LOGO'}${goto '$VOFF'}'$BASE'Total: '$HILIGHT'${totalup '$ACTIVE'}' >> ~/.conkyrc
		echo $BASE'${voffset -'$ALEFT'}${font VariShapes Solid:pixelsize='$FONTSIZE'}Q${goto '$VOFF'}${voffset -'$ALEFT'}'$BASE'Down: '$HILIGHT'${downspeed '$ACTIVE'} '$BAR'${alignr}${downspeedgraph '$ACTIVE' '$LOGO','$BPER' ${font} '$BAR'}' >> ~/.conkyrc
		echo $BASE'${font}${voffset -'$LOGO'}${goto '$VOFF'}Total: '$HILIGHT'${totaldown '$ACTIVE'}'$BASE >> ~/.conkyrc

		# Provide wireless info if user is using wireless actively.
		if [[ "$wlan" == "up" ]]; then

			#Wireless header
			echo $HEADER'Wireless: '$ACTIVE'${hr 2 }' >> ~/.conkyrc

			# ACCESS POINT
			echo '${voffset 2}${font VariShapes Solid:pixelsize='$FONTSIZE'}-${goto '$VOFF'}${voffset -'$ALEFT'}${font}Wireless Access Point: '$HILIGHT'${alignr}${wireless_essid '$ACTIVE'}' >> ~/.conkyrc

			# Connection strength / signal
			echo '${font}${voffset 2}${font Stylebats:pixelsize='$FONTSIZE'}Z${goto '$VOFF'}${voffset -'$ALEFT'}${font}Connection strength: '$HILIGHT'${alignr}${wireless_link_qual_perc '$ACTIVE'}%' >> ~/.conkyrc

			# Connection speed
			echo '${font}${voffset 2}${font Stylebats:pixelsize='$FONTSIZE'}C${goto '$VOFF'}${voffset -'$ALEFT'}${font}Connection max throughput: '$HILIGHT'${alignr}${wireless_bitrate '$ACTIVE'}' >> ~/.conkyrc
		fi

		# echo $HEADER'${voffset -'$ALEFT'}${hr 2}' >> ~/.conkyrc

		# Provide general connection info
		echo -n '${font}${voffset -'$ALEFT'}${font Poky:pixelsize='$FONTSIZE'}w${goto '$VOFF'}${voffset -'$ALEFT'}${font}Local IP: '$HILIGHT'${addr '$ACTIVE'}${alignr}' >> ~/.conkyrc
		echo $BASE'${font}${voffset 2}${font Stylebats:pixelsize='$FONTSIZE'}M${font}TCP Connections: '$HILIGHT'${tcp_portmon 1 65535 count}' >> ~/.conkyrc
	fi
	echo $HEADER'${voffset -'$ALEFT'}${hr 2}' >> ~/.conkyrc
	# Close out with a thin line at the bottom & the Date / Time
	echo $BASE'${goto '$INDENT'}${voffset '$TICON'}${font Poky:pixelsize='$FONTSIZE'}d${voffset -'$ALEFT'}${goto '$VOFF'}'$HEADER'${goto '$VOFF'}${alignc}${time %H:%M}, ${time %A %d %B}' >> ~/.conkyrc
	echo "$HEADER" >> ~/.conkyrc
	#'${voffset -'$ALEFT'}${hr 2}'
	if [[ -f "/tmp/mpoint.txt" ]]; then
		Encapsulate "Cleaning up."
		rm -f "/tmp/mpoint.txt"
	fi
	Notification "Conky builder system detection complete."
	Timer "Stop"
	FullBar
	exit 0 # make sure we exit graciously, we want to add to boot-up with && to allow
	# other processes to continue.  No sense in being a hog and slowing boot time.
}

# Help system - I have re-wrote this section to work with code-cleanup.
function Help() {

	if [[ "$2" == "" ]]; then
		VersionDump
		PRAM="ALL"
	else
		if ! [[ $3 ]]; then
			VersionDump
			PRAM="$2"
		else
			PRAM="$2"
		fi
	fi

	case "$PRAM" in
		ALL)
		Center "Usage: $PROGNAME -<-COMMAND> [OPTION]"
		Encapsulate "Mandatory arguments to long options are identical for short options."
		Encapsulate "  possible commands..."
		Encapsulate ""
		Encapsulate "  -h	--help		this help message"
		Encapsulate "  -v	--version	dump version info and exit"
		Encapsulate ""
		Encapsulate "$PROGNAME --help [COMMAND] for further information.";
		FullBar;;
		ALL|v|version)
		Encapsulate ""
		Encapsulate "Usage version;"
		Encapsulate "$PROGNAME -v"
		Encapsulate "Displays $PROGNAME version number and exits.";
		FullBar;;
		ALL|h|help|\?)
		Encapsulate ""
		Encapsulate "Useage Help [COMMAND];"
		Encapsulate "$PROGNAME -h [COMMAND]"
		Encapsulate "Displays this message. For futher information $PROGNAME help [COMMAND]"
		Encapsulate "or refer to the manpages."
		Encapsulate ""
		Encapsulate "man $PROGNAME"
		Encapsulate ""
		Encapsulate "Example: $PROGNAME -h version"
		Encapsulate "Will display help about the command version"
		Fullbar;;
	esac
	exit 0
}

Timer "Start"

case "$1" in
	-h|--help|-\?) Help "$@"; exit 0;;
	-v|--version) VersionDump "$@"; exit 0;;
	*) Main "$@"; exit 0;;
esac


# ==============================================================================
# This code was automatically cleaned up using code-cleanup
# title			:code-cleanup
# description		:Bash code cleanup script
# Author		:root
# date			:10/23/2013
# version		:1.7.2-1
# http://ultimateedition.info/
# ==============================================================================
