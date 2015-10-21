#!/bin/bash

# check to see that the number of arguments are valid
VALID_NUMBER_OF_ARGS=5
if [ $# -ne $VALID_NUMBER_OF_ARGS ]
then
	echo 'Usage: ./uploadToHockeyApp.sh <API_TOKEN> <APP_ID> <BRANCH_NAME> <VERSION_NUMBER> <DMG_LOCATION>'
	exit 128
fi

# store off the arguments
API_TOKEN="$1"
APP_ID="$2"
BRANCH_NAME="$3"
VERSION_NUMBER="$4"
DMG_LOCATION="$5"

# check to make sure the dmg location provided exists
if [ ! -f "$DMG_LOCATION" ]
then
	echo 'dmg does not exist:' $DMG_LOCATION
	exit 128
fi

# Use the branch's commit history as the release notes
RELEASE_NOTES=`git log --walk-reflogs $BRANCH_NAME --pretty=format:"%an: %s" -10`
echo "Using git log for release notes:"
echo $RELEASE_NOTES


# HockeyApp Create Version API: http://support.hockeyapp.net/kb/api/api-versions#create-version
# 1. use curl to create a new version for the app on HockeyApp
# 2. use a python script to parse the returned JSON to get back the 'id' value and store it

echo 'Creating a new version for the app on HockeyApp...'
RETRIEVED_ID=`curl \
  -F "bundle_short_version=$BRANCH_NAME" \
  -F "bundle_version=$VERSION_NUMBER" \
  -F "notes=$RELEASE_NOTES" \
  -F "status=2" \
  -H "X-HockeyAppToken: "$API_TOKEN \
  https://rink.hockeyapp.net/api/2/apps/$APP_ID/app_versions/new | python -c "import sys, json; print(json.load(sys.stdin)['id'])"`

# HockeyApp Update Version API: http://support.hockeyapp.net/kb/api/api-versions#update-version
# upload the version that was just created on HockeyApp with the dmg file
# NOTE: in terms of the HockeyApp API, we're actually 'updating' the version, not 'uploading'

echo 'Uploading' $DMG_LOCATION 'to HockeyApp...'
curl \
  -X PUT \
  -F "status=2" \
  -F "notify=1" \
  -F "ipa=@$DMG_LOCATION" \
  -H "X-HockeyAppToken: "$API_TOKEN \
  https://rink.hockeyapp.net/api/2/apps/$APP_ID/app_versions/$RETRIEVED_ID


