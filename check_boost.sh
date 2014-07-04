#!/bin/sh
#wget --content-disposition -nc http://sourceforge.net/projects/boost/files/latest/download

for i in boost_*.tar.gz; do
  TOCHECK=${i%.tar.gz}
  echo Checking if $TOCHECK exists ...
  if [ ! -d $TOCHECK ]; then
    echo Untarring $i ...
    tar zxf $i
    echo Copying $TOCHECK into boost-release ...
    rm -rf boost-release/*
    cp -a $TOCHECK/* boost-release/
    cd boost-release
    echo Committing $TOCHECK to boost-release ...
    git add .
    git commit -a -m "${TOCHECK} release on $(date)"
    git tag $TOCHECK
    git push --tags origin master
    cd ..
  fi
done

