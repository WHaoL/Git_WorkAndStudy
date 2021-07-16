


case `uname -s` in
"Linux")
    PLATFORM="linux"
    ;;
"FreeBSD")
    echo "Do not support freebsd"
    exit 1
    ;;
"Darwin")
    echo "Do not support macos"
    exit 1
	;;
"SunOS")
    echo "Do not support solaris"
    exit 1
	;;
*)
    echo "Unsupported version, please use the linux version"
    exit 1
esac
echo $PLATFORM
exit 0