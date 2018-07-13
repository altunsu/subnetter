#!/bin/bash
#title           :subnetter.sh
#description     :Calculates subnets without leaving orphan ip.
#author		 :altunsu@gmail.com
#date            :2015.01.01
#Warning         :Downloading, developing, using this script is totaly free, please use subnetter at your own risk.

values=("$@")

blockTOTAL=${values[0]}
IFS='/' read -ra SPL <<< "$blockTOTAL"
IPADDR=${SPL[0]}

############### BITS EXPLODE ###################
IFS='.' read -ra BITS <<< "$IPADDR"
BITS1=${BITS[0]}
BITS2=${BITS[1]}
BITS3=${BITS[2]}
BITS4=${BITS[3]}
################################################
CIDR=${SPL[1]}

if [ -z "$BITS1" ] || [ -z "$BITS2" ] || [ -z "$BITS3" ] || [ -z "$BITS4" ] || [ -z "$CIDR" ]
then
##    echo $BITS1 $BITS2 $BITS3 $BITS4
    echo "################################################################################################################################"
    echo "#                                                                                                                              #"
    echo "# Parameters error  script usage is #./subnetter.sh ip address/subnet desired number of ip address | example: 192.168.1.1/24 6 #"
    echo "#                                                                                                                              #"
    echo "################################################################################################################################"
    exit 1;
fi

numberDIVIDE=${values[1]}
declare -a mynumbers=([24]="1#256" [25]="2#128" [26]="4#64" [27]="8#32" [28]="16#16" [29]="32#8" [30]="64#4")
sonya=${mynumbers[$CIDR]}
IFS='#' read -ra MPL <<< "$sonya"
TOTAL_SUBNET=${MPL[0]}
AVAIL_HOST=${MPL[1]}

function goodbye
{
    local message=$1
    [ -z "$message" ] && message="I am done ===> Happy Networking" 
    echo "${BASH_SOURCE[1]}: line ${BASH_LINENO[0]}: ${FUNCNAME[1]}: $message." >&2
    exit 1
}

function nohost
{
    local message=$1
    [ -z "$message" ] && message="Sorry no enough host to provide" 
    echo "${BASH_SOURCE[1]}: line ${BASH_LINENO[0]}: ${FUNCNAME[1]}: $message." >&2
    exit 1
}


function die
{
    local message=$1
    [ -z "$message" ] && message="Alert: You can not substitude network less than $TOTAL_SUBNET subnets" 
    echo "${BASH_SOURCE[1]}: line ${BASH_LINENO[0]}: ${FUNCNAME[1]}: $message." >&2
    exit 1
}

if [ $((AVAIL_HOST/numberDIVIDE)) -lt 4 ]
then
echo $TOTAL_HOST $numberDIVIDE
nohost
fi

function check_result {
bride=${mynumbers[$CIDR+$i]}
IFS='#' read -ra DPK <<< "$bride"
LIZARD=${DPK[0]}"@"${DPK[1]}"@"$((CIDR+$i))
}

function half_result {
declare -a mini=( [256]="24#1" [128]="25#2" [64]="26#4" [32]="27#8" [16]="28#16" [8]="29#32" [4]="30#64")
for x in `seq 1 $2`;
do
ZPT=$1
BX1=${mini[$1]}
IFS='#' read -ra JPK1 <<< "$BX1"
echo "subnet="$BITS1"."$BITS2"."$BITS3"."$((BITS4+(ZPT*(x-1))))"/"${JPK1[0]} "network="$BITS1"."$BITS2"."$BITS3"."$((BITS4+(ZPT*(x-1)))) "broadcast="$BITS1"."$BITS2"."$BITS3"."$(((BITS4+(ZPT*(x-1)))+ZPT-1)) "gateway="$BITS1"."$BITS2"."$BITS3"."$(((BITS4+(ZPT*(x-1)))+1)) "host="$((ZPT-3))
done

for x in `seq 1 $4`;
do
MPT=$3
BX2=${mini[$3]}
IFS='#' read -ra JPK2 <<< "$BX2"
echo "subnet="$BITS1"."$BITS2"."$BITS3"."$((((ZPT*$2)+(MPT*(x-1)))+BITS4))"/"${JPK2[0]} "network="$BITS1"."$BITS2"."$BITS3"."$((((ZPT*$2)+(MPT*(x-1)))+BITS4)) "broadcast="$BITS1"."$BITS2"."$BITS3"."$((((ZPT*$2)+((MPT*(x-1)))+MPT-1)+BITS4)) "gateway="$BITS1"."$BITS2"."$BITS3"."$((((ZPT*$2)+((MPT*(x-1)))+1)+BITS4)) "host="$((MPT-3))
done
goodbye
}



function half_attempt {
IFS='.' read -ra BITS <<< "$IPADDR"
BITS1=${BITS[0]}
BITS2=${BITS[1]}
BITS3=${BITS[2]}
BITS4=${BITS[3]}
DIVA=$(((AVAIL_HOST/numberDIVIDE)+1))

for m in `seq $DIVA 256`;
do

case $m in
   "4")
    if [ $((numberDIVIDE*m)) -gt $AVAIL_HOST ]
    then
    VSML=$((((numberDIVIDE*m)-AVAIL_HOST)/(m/2)))
    VBIG=$((numberDIVIDE-VSML))
    half_result $m $VBIG  $m $VSML
    else
    half_result $m $numberDIVIDE 0 0
    fi
    die ;;
   "8")
    if [ $((numberDIVIDE*m)) -gt $AVAIL_HOST ]
    then
    VSML=$((((numberDIVIDE*m)-AVAIL_HOST)/(m/2)))
    VBIG=$((numberDIVIDE-VSML))
    half_result $m $VBIG  $((m/2)) $VSML
    else
    half_result $m $numberDIVIDE 0 0
    fi
   die ;;
   "16")
    if [ $((numberDIVIDE*m)) -gt $AVAIL_HOST ]
    then
    VSML=$((((numberDIVIDE*m)-AVAIL_HOST)/(m/2)))
    VBIG=$((numberDIVIDE-VSML))
    half_result $m $VBIG  $((m/2)) $VSML
    else
    half_result $m $numberDIVIDE 0 0
    fi
   die ;;
   "32")
    if [ $((numberDIVIDE*m)) -gt $AVAIL_HOST ]
    then
    VSML=$((((numberDIVIDE*m)-AVAIL_HOST)/(m/2)))
    VBIG=$((numberDIVIDE-VSML))
    half_result $m $VBIG  $((m/2)) $VSML
    else
    half_result $m $numberDIVIDE 0 0
    fi
   die ;;
   "64")
    if [ $((numberDIVIDE*m)) -gt $AVAIL_HOST ]
    then
    VSML=$((((numberDIVIDE*m)-AVAIL_HOST)/(m/2)))
    VBIG=$((numberDIVIDE-VSML))
    half_result $m $VBIG  $((m/2)) $VSML
    else
    half_result $m $numberDIVIDE 0 0
    fi
    die ;;
    "128")
    if [ $((numberDIVIDE*m)) -gt $AVAIL_HOST ]
    then
    VSML=$((((numberDIVIDE*m)-AVAIL_HOST)/(m/2)))
    VBIG=$((numberDIVIDE-VSML))
    half_result $m $VBIG  $((m/2)) $VSML
    else
    half_result $m $numberDIVIDE 0 0
    fi
    die ;;
    "256")
    if [ $((numberDIVIDE*m)) -gt $AVAIL_HOST ]
    then
    VSML=$((((numberDIVIDE*m)-AVAIL_HOST)/(m/2)))
    VBIG=$((numberDIVIDE-VSML))
    half_result $m $VBIG  $((m/2)) $VSML
    else
    half_result $m $numberDIVIDE 0 0
    fi
    die ;;
   *);;
    esac
done
}


function full_attempt {
IFS='.' read -ra BITS <<< "$IPADDR"
BITS1=${BITS[0]}
BITS2=${BITS[1]}
BITS3=${BITS[2]}
BITS4=${BITS[3]}

######## IF EQL SUBNT
if [ $1 -eq $TOTAL_SUBNET  ] && [ $BITS4 -eq 0  ]
then
for g in `seq 1 $1`;
do
echo "subnet="$BITS1"."$BITS2"."$BITS3"."$((((g-1)*AVAIL_HOST)/TOTAL_SUBNET))"/"$CIDR "network="$BITS1"."$BITS2"."$BITS3"."$((((g-1)*AVAIL_HOST)/TOTAL_SUBNET)) "broadcast="$BITS1"."$BITS2"."$BITS3"."$((((g)*AVAIL_HOST)/TOTAL_SUBNET)) "gateway="$BITS1"."$BITS2"."$BITS3"."$(((((g-1)*AVAIL_HOST)/TOTAL_SUBNET)+1)) "host="$(((AVAIL_HOST/TOTAL_SUBNET)-3))
done
goodbye
fi

######### IF NOQL SUBNET
for i in `seq 1 $((30-CIDR))`;
do
check_result $i
IFS='@' read -ra NBT <<< "$LIZARD"
NCDR=${NBT[0]}
NSUBNET=${NBT[1]}
NHOST=${NBT[2]}
#if [ $1 -eq $NCDR ] && [ $((AVAIL_HOST/numberDIVIDE)) -gt $NSUBNET ]
if [ $1 -eq $NCDR ] && [ $BITS4 -eq 0  ]
then
for g in `seq 1 $1`;
do
echo "subnet="$BITS1"."$BITS2"."$BITS3"."$(((g-1)*NSUBNET))"/"$NHOST "network="$BITS1"."$BITS2"."$BITS3"."$(((g-1)*NSUBNET)) "broadcast="$BITS1"."$BITS2"."$BITS3"."$(((g*NSUBNET)-1)) "gateway="$BITS1"."$BITS2"."$BITS3"."$((((g-1)*NSUBNET)+1)) "host="$((NSUBNET-3))
done
goodbye
fi
done
half_attempt $1
}

full_attempt $numberDIVIDE