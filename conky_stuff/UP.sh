#!/bin/bash
# Ultimate Player display script by TheeMahn <theemahn@ultimateedition.info>
#
# requirements: ultimate-player (!), qdbus, radiotray
#

#function (UP)

case "$1" in
# Now Playing Info
artist)
   ART=$(qdbus org.mpris.MediaPlayer2.ultimateplayer /Player org.freedesktop.MediaPlayer.GetMetadata | grep arturl:  | cut -b 9- | sed 's/file:\/\///g');
   qdbus org.mpris.MediaPlayer2.ultimateplayer /Player org.freedesktop.MediaPlayer.GetMetadata | grep artist: | cut -b 9-;
   cp $ART ~/.config/Ultimate-Player/Current.art;;
title)
   qdbus org.mpris.MediaPlayer2.ultimateplayer /Player org.freedesktop.MediaPlayer.GetMetadata | grep title: | cut -b 8- ;;
album)
   qdbus org.mpris.MediaPlayer2.ultimateplayer /Player org.freedesktop.MediaPlayer.GetMetadata | grep album: | cut -b 8- ;;
year)
   qdbus org.mpris.MediaPlayer2.ultimateplayer /Player org.freedesktop.MediaPlayer.GetMetadata | grep year: | cut -b 7- ;;
genre)
   qdbus org.mpris.MediaPlayer2.ultimateplayer /Player org.freedesktop.MediaPlayer.GetMetadata | grep genre: | cut -b 8- ;;
rplay)
   qdbus net.sourceforge.radiotray /net/sourceforge/radiotray getCurrentMetaData;;
rstation)
   qdbus net.sourceforge.radiotray /net/sourceforge/radiotray net.sourceforge.radiotray.getCurrentRadio;;
progress)
    curr=`qdbus org.mpris.ultimateplayer /Player PositionGet`
    tot=`qdbus org.mpris.ultimateplayer /Player GetMetadata | grep mtime: | cut -b 8-`
    if (( $tot )); then
expr $curr \* 100 / $tot
    fi
    ;;
currenttime)
    tmp=`qdbus org.mpris.ultimateplayer /Player PositionGet`
    min=`expr $tmp / 60000`
    sec_full=`expr $tmp % 60000`
    c=`expr $sec_full \< 10000`
    if (($c)); then
sec=`expr substr $sec_full 1 1`
        echo $min:0$sec
    else
sec=`expr substr $sec_full 1 2`
        echo $min:$sec
    fi
    ;;
totaltime)
    tmp=`qdbus org.mpris.ultimateplayer /Player GetMetadata | grep mtime: | cut -b 8-`
    min=`expr $tmp / 60000`
    sec_full=`expr $tmp % 60000`
    c=`expr $sec_full \< 10000`
    if (($c)); then
sec=`expr substr $sec_full 1 1`
        echo $min:0$sec
    else
sec=`expr substr $sec_full 1 2`
        echo $min:$sec
    fi
    ;;
timeleft)
    curr=`qdbus org.mpris.ultimateplayer /Player PositionGet`
    tot=`qdbus org.mpris.ultimateplayer /Player GetMetadata | grep mtime: | cut -b 8-`
    left=`expr $tot - $curr`
    min=`expr $left / 60000`
    sec_full=`expr $left % 60000`
    c=`expr $sec_full \< 10000`
    if (($c)); then
sec=`expr substr $sec_full 1 1`
        echo $min:0$sec
    else
sec=`expr substr $sec_full 1 2`
        echo $min:$sec
    fi
    ;;

esac
