#!/usr/bin/env bash

REPOSLUG=office-tools/reading-time-app

function statuses () {
  curl -s -H "Authorization: Token $GITHUB_TOKEN" -H "Accept: application/json" -H "Content-type: application/json" -X POST -d '{"state": "'"$1"'","target_url": "https://reading-time-app.herokuapp.com/","description": "'"$2"'"}' https://octodemo.com/api/v3/repos/$REPOSLUG/deployments/$deployment_id/statuses
}

: ${GITHUB_TOKEN?"Please set environment variable GITHUB_TOKEN to the GitHub access token"}

BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')

read -p  "Do you want to deploy branch '$BRANCH' (y/N)?" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  deployment_id=$(curl -s -H "Authorization: Token $GITHUB_TOKEN" -H "Accept: application/json" -H "Content-type: application/json" -X POST -d '{"ref": "'"$BRANCH"'","description": "Deploying branch to staging", "environment": "staging"}' https://octodemo.com/api/v3/repos/$REPOSLUG/deployments | jq '.id')
  echo "Deployment ID: $deployment_id"
  if (($deployment_id == null))
  then
    echo "Create deployment failed, please check the branch name '${branch}' and if the last build passed"
    exit 1
  fi
  statuses "pending" "Pending deployment to staging"
  sleep 10
  statuses "success" "Successful deployment to staging"
fi
