#!/bin/bash
#*******************************************************************************
# Copyright 2019-2021 FUJITSU LIMITED
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# imitations under the License.
# *******************************************************************************/
RESULT=0

make -j$(nproc)

for i in make_nm*.cpp ; do
    FILE_NAME=`basename ${i} .cpp`

    if [ -f ${FILE_NAME}.ok ] ;then
	COUNT_OK=`wc -l ${FILE_NAME}.ok | sed -e "s/^[ \t]*//" | cut -f 1 -d " "`
    else
	RESULT=1
    fi

    if [ -f ${FILE_NAME}.result ] ; then
	COUNT_ERR=`wc -l ${FILE_NAME}.result | sed -e "s/^[ \t]*//" | cut -f 1 -d " "`
	if [ ! $? -eq 0 ] ; then
	    RESULT=1
	fi
    else
	RESULT=1
    fi

    echo "${FILE_NAME} ${COUNT_OK} ${COUNT_ERR}"
done

wc -l *.ok | tail -n 1

exit ${RESULT}
