#!/bin/sh

date=$(date '+%H%M%S')

divider() {
  echo "一一一一一一一一一一一一一一一一一一一一一一一一一"
}
check_dir(){
  mkdir -p install
}

build_dev_ios() {
  rm -rf install/satu-*
  flutter build ipa --release --export-method ad-hoc
  cp build/ios/ipa/satu.ipa "install/satu-$date.ipa"
  divider
}

build_prod_ios() {
  rm -rf install/Runner.xcarchive/
  flutter build ipa --release
  cp -R build/ios/archive/Runner.xcarchive/ install/satu.xcarchive/
  rm -rf build/ios/archive
  divider
}

check_dir

if [ -z "$1" ]; then 
  build_dev_ios
elif [ $1 == "dev" ]; then 
  if [ -z "$2" ]; then 
    divider
    build_dev_ios
  elif [ $2 == "ios" ]; then 
    build_dev_ios
  else
    echo "$2 Not Support."
  fi 
elif [ $1 == "release" ]; then 
  if [ -z "$2" ]; then 
    divider
    build_prod_ios
  elif [ $2 == "ios" ]; then 
    build_prod_ios
  else
    echo "$2 Not Support."
  fi
elif [ $1 == "clean" ]; then 
  rm -rf install/app-release.apk
  rm -rf install/app-release.aab
  rm -rf install/Runner.xcarchive/
else
	echo " Support Arg."
	echo "  [ dev      ][ios] : build for test."
	echo "  [ release  ][ios] : build for release"
	echo "  [ clean    ] : build for release"
fi 
