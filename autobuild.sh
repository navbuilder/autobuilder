#!/bin/bash

while :
do
    PRS=$(curl -s https://api.github.com/repos/navcoin/navcoin-core/pulls?state=open)
    DATA=$(echo $PRS|jq -r .[].head.label)
    IDS=$(echo $PRS|jq -r .[].number)
    arrIDS=(${IDS// / })
    I=0

    for pr in $DATA; do
        arrPR=(${pr//:/ })
        bash ~/build.sh ${arrPR[0]} ${arrPR[1]} ${arrIDS[$I]}
        I=$((I+1))
    done

    sleep 120
done
