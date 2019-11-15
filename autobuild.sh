#!/bin/bash

ACCESS_TOKEN=g17h084cc351704e1

while :
do
    PRS=$(curl -s https://api.github.com/repos/navcoin/navcoin-core/pulls?state=open)
    DATA=$(echo $PRS|jq -r .[].head.label)
    IDS=$(echo $PRS|jq -r .[].number)
    arrIDS=(${IDS// / })
    I=0

    for pr in $DATA; do
        arrPR=(${pr//:/ })
        bash ~/build.sh ${arrPR[0]} ${arrPR[1]} ${arrIDS[$I]} && \
        curl -s -H "Authorization: token ${ACCESS_TOKEN}" \
         -X POST -d '{"body": "A new build of $(cat ~/public_html/binaries/${arrPR[1]}/.lastbuild) has completed succesfully!\nBinaries available at https://build.nav.community/binaries/${arrPR[0]}"}' \
         "https://api.github.com/repos/${arrPR[0]}/navcoin-core/issues/${arrIDS[$I]}/comments"
        I=$((I+1))
    done
    
    bash ~/build.sh navcoin master 0

    sleep 120
done
