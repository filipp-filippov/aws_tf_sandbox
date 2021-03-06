#!/usr/bin/env bash

OU="$1"
ACCOUNT_NAME="$2"
LAYER="$3"
ACTION="$4"
EXTRA="${@:5}"

showusage() {
  echo -e "Exactly four mandatory arguments required:\n
  1. OU e.g. dev_ou, prod_ou, etc...\n
  2. ACCOUNT_NAME e.g. dev1_acct, dev2_acct, etc...\n
  3. LAYER e.g. networking, compute, db, etc...\n
  4. ACTION e.g. plan, apply, destroy\n
  Rest arguments will be merged and provided as a string after mandatory args\n"
}

if [ "${OU}" == "" ]
then
  echo "You should specify OU parameter"
  showusage
  kill -9 $$
elif [ "$(find ./environments -type d -name "${OU}" | grep -q \.; echo $?)" != "0" ];
  then
    echo "Specified OU not found"
    showusage
    kill -9 $$
fi

if [ "${ACCOUNT_NAME}" == "" ]
then
  echo "You should specify ACCOUNT_NAME parameter"
  showusage
  kill -9 $$
elif [ "$(find ./environments/${OU} -type d -name "${ACCOUNT_NAME}" | grep -q \.; echo $?)" != "0" ];
  then
    echo "Specified ACCOUNT_NAME not found"
    showusage
    kill -9 $$
fi

if [ "${LAYER}" == "" ]
then
  echo "You should specify LAYER parameter"
  showusage
  kill -9 $$
elif [ "$(find ./environments/${OU}/${ACCOUNT_NAME} -type d -name "${LAYER}" | grep -q \.; echo $?)" != "0" ];
  then
    echo "Specified LAYER not found"
    showusage
    kill -9 $$
fi

case ${ACTION} in
    plan) terraform -chdir="./environments/${OU}/${ACCOUNT_NAME}/${LAYER}" init -reconfigure &&
          terraform -chdir="./environments/${OU}/${ACCOUNT_NAME}/${LAYER}" validate &&
          terraform -chdir="./environments/${OU}/${ACCOUNT_NAME}/${LAYER}" plan $(echo "${EXTRA}")
          ;;
   apply) terraform -chdir="./environments/${OU}/${ACCOUNT_NAME}/${LAYER}" init -reconfigure &&
          terraform -chdir="./environments/${OU}/${ACCOUNT_NAME}/${LAYER}" validate &&
          terraform -chdir="./environments/${OU}/${ACCOUNT_NAME}/${LAYER}" apply $(echo "${EXTRA}")
          ;;
 destroy) terraform -chdir="./environments/${OU}/${ACCOUNT_NAME}/${LAYER}" init -reconfigure &&
          terraform -chdir="./environments/${OU}/${ACCOUNT_NAME}/${LAYER}" destroy $(echo "${EXTRA}")
          ;;
       *) echo "You should specify ACTION parameter"
          showusage
          kill -9 $$
          ;;
esac