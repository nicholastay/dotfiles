#!/bin/sh
/usr/libexec/pam_kwallet_init &
exec qdbus org.freedesktop.ScreenSaver /ScreenSaver Lock
