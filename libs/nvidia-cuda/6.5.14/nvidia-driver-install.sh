#!/bin/bash
################################################################################
# (c) Copyright 2007-2009 Alces Software Ltd & Stephen F Norledge.             #
#                                                                              #
# HPC Cluster Toolkit                                                          #
#                                                                              #
# This file/package is part of the HPC Cluster Toolkit                         #
#                                                                              #
# This is free software: you can redistribute it and/or modify it under        #
# the terms of the GNU Affero General Public License as published by the Free  #
# Software Foundation, either version 3 of the License, or (at your option)    #
# any later version.                                                           #
#                                                                              #
# This file is distributed in the hope that it will be useful, but WITHOUT     #
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or        #
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License #
# for more details.                                                            #
#                                                                              #
# You should have received a copy of the GNU Affero General Public License     #
# along with this product.  If not, see <http://www.gnu.org/licenses/>.        #
#                                                                              #
# For more information on Alces Software, please visit:                        #
# http://www.alces-software.org/                                               #
#                                                                              #
################################################################################
# chkconfig: 2345 49 91
# alces-nvidia: Loads nvidia device entries where GPU cards are present without a graphical X-Windows environment
# description: Creates device entries for Nvidia GPU cards
#
. /etc/rc.d/init.d/functions

install_driver()
{
  if ! ( /sbin/modinfo nvidia ); then
    echo
    echo -n "Installing NVIDIA driver.."
    %NVIDIAINSTALLER% --kernel-name=`uname -r` --no-network --silent --disable-nouveau --log-file-name=/tmp/alces-nvidia-installer.log
    if [ "$?" -eq 0 ]; then
      echo OK
    else
      failure
      exit 1
    fi  
  fi
}


start()
{
  install_driver 
  echo -n Loading NVIDIA GPU driver and creating devices:
  /sbin/modprobe nvidia

if [ "$?" -eq 0 ]; then 

  # Count the number of NVIDIA controllers found. 
  NVDEVS=`lspci | grep -i NVIDIA` 
  N3D=`echo "$NVDEVS" | grep "3D controller" | wc -l` 
  NVGA=`echo "$NVDEVS" | grep "VGA compatible controller" | wc -l` 

  N=`expr $N3D + $NVGA - 1` 
  for i in `seq 0 $N`; do 
     mknod -m 666 /dev/nvidia$i c 195 $i 
  done 
  
  mknod -m 666 /dev/nvidiactl c 195 255 

  success

else 
  failure
fi

}

stop()
{
  # Nothing to do here
  echo nothing > /dev/null   
}

running()
{
  test -c /dev/nvidia0

}
case "$1" in
  start)
    running && echo Nvidia device files already exist || start
  ;;
  stop)
    running && stop || echo No Nvidia device files detected
  ;;
  restart)
    stop
    start
  ;;
  status)
    running && echo "Nvidia device files present" || echo "Nvidia device files not present"
  ;;
  *)
    echo "Usage: $0 {start|stop|restart|status}"
esac 
