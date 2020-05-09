#!/usr/bin/env bash

set -ue

source $( dirname "${BASH_SOURCE[0]}" )/common_vars

export AWS_PROFILE=$AWS_PROFILE                                         \
 TF_VAR_aws_region=$AWS_DEFAULT_REGION                                  \
 TF_VAR_aws_profile=$AWS_PROFILE                                        \
 TF_VAR_aws_account_id=$AWS_ACCOUNT_ID

# Source additional variables
if [ -f variables.sh ]; then
  source variables.sh
fi

terraform "$@"
