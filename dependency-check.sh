#!/bin/sh

DC_DIRECTORY=$HOME/OWASP-Dependency-Check
DC_PROJECT="dependency-check scan: $(pwd)"
DATA_DIRECTORY="$DC_DIRECTORY/data"
CACHE_DIRECTORY="$DC_DIRECTORY/data/cache"

if [ ! -d "$DATA_DIRECTORY" ]; then
    echo "Initially creating persistent directory: $DATA_DIRECTORY"
    mkdir -p "$DATA_DIRECTORY"
fi
if [ ! -d "$CACHE_DIRECTORY" ]; then
    echo "Initially creating persistent directory: $CACHE_DIRECTORY"
    mkdir -p "$CACHE_DIRECTORY"
fi

sudo wget -O $SCA_PATH $SCA_URL --quiet
sudo unzip -q -o $SCA_PATH -d /opt/
export PATH=/opt/dependency-check/bin:$PATH
sudo bash /opt/dependency-check/bin/dependency-check.sh --project ${PROJECT_NAME} --scan . -f XML --out reports/dependency-check-report.xml

cat reports/dependency-check-report.xml
sudo apt-get install jq
sudo pip install archerysec-cli

DATE=`date +%Y-%m-%d`

PROJECT_ID=`archerysec-cli -s $ARCHERYSEC_HOST -u $ARCHERYSEC_USER -p $ARCHERYSEC_PASS --createproject \
--project_name=$PROJECT_NAME --project_disc=$PROJECT_DISC  --project_start=$DATE \
--project_end=$DATE --project_owner=$PROJECT_OWNER | tail -n1 | jq '.project_id' | sed -e 's/^"//' -e 's/"$//'`

echo $PROJECT_ID
echo $GITHUB_SHA

SCAN_ID=`archerysec-cli -s $ARCHERYSEC_HOST -u $ARCHERYSEC_USER -p $ARCHERYSEC_PASS --upload --file_type=XML \
--file=reports/dependency-check-report.xml --TARGET=$GITHUB_SHA --scanner=dependencycheck \
--project_id=$PROJECT_ID | tail -n1 | jq '.scan_id' | sed -e 's/^"//' -e 's/"$//'`

sleep 20
echo "Scan Report Uploaded Successfully, Scan Id:"$SCAN_ID