#!/bin/bash

if [ ! -e /etc/redhat-release ] ; then
    echo "Cannot find '/etc/redhat-release'."
    echo "Abort since this script assumes Scientific Linux."
    exit 1
fi
if ! grep -q 'Scientific Linux release 7.6' /etc/redhat-release ; then
    echo "The OS version seems not SL 7.6."
    echo "Abort since this script assumes this version."
    exit 1
fi


LIST_ALL="$(yum list installed)"

declare -a LIST_PKG=()
while read PKG ; do
    echo "$LIST_ALL" | grep -q "^${PKG}\." || LIST_PKG+=("$PKG")
done <<EOF
  screen
  git-all
  cmake
  doxygen
  mariadb-devel
  sqlite-devel
  zlib-devel
  freetype-devel
  pcre-devel
  xz-devel
  lz4-devel
  libX11-devel
  libXpm-devel
  libXft-devel
  libXext-devel
  fftw-devel
  gsl-devel
  libxml2-devel
  openssl-devel
  libXmu-devel
  xerces-c-devel
  mesa-libGL-devel
  mesa-libGLU-devel
EOF

if [ ${#LIST_PKG[*]} -eq 0 ] ; then
    echo "All the essential packages have been already installed.  OK."
else
    echo "Some essential packages were found not installed."
    echo "Execute the following command as root:"
    echo "  yum install ${LIST_PKG[*]}"
    exit 1
fi
exit 0


#yum install \
#  screen git-all cmake doxygen \
#  mariadb-devel sqlite-devel \
#  zlib-devel \
#  freetype-devel pcre-devel xz-devel lz4-devel libX11-devel \
#  libXpm-devel libXft-devel libXext-devel libfftw-devel \
#  gsl-devel libxml2-devel openssl-devel
