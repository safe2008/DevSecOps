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

echo $DC_VERSION
echo $DATA_DIRECTORY
echo $DC_PROJECT
echo $USER

# Make sure we are using the latest version
docker pull owasp/dependency-check:$DC_VERSION

docker run --rm \
-e user=$USER \
-u $(id -u ${USER}):$(id -g ${USER}) \
--volume $(pwd):/src:z \
--volume $DATA_DIRECTORY:/usr/share/dependency-check/data:z \
--volume $(pwd)/odc-reports:/report:z \
owasp/dependency-check:$DC_VERSION \
--scan /src \
--format "ALL" \
--project $DC_PROJECT \
--out /report

cat odc-reports/dependency-check-report.xml
# sudo apt-get install jq
# sudo pip install archerysec-cli

DATE=`date +%Y-%m-%d`
echo $DATE
# create project in archerysec
# PROJECT_ID=`archerysec-cli -s ${{ secrets.ARCHERYSEC_HOST }} -u ${{ secrets.ARCHERYSEC_USER }} -p ${{ secrets.ARCHERYSEC_PASS }} --createproject \
# --project_name=$PROJECT_NAME --project_disc=$PROJECT_DISC  --project_start=$DATE \
# --project_end=$DATE --project_owner=$PROJECT_OWNER | tail -n1 | jq '.project_id' | sed -e 's/^"//' -e 's/"$//'`
# echo $PROJECT_ID

# Upload Scan report in archerysec
# SCAN_ID=`archerysec-cli -s ${{ secrets.ARCHERYSEC_HOST }} -u ${{ secrets.ARCHERYSEC_USER }} -p ${{ secrets.ARCHERYSEC_PASS }} --upload --file_type=XML \
# --file=odc-reports/dependency-check-report.xml --TARGET=$GITHUB_SHA --scanner=dependencycheck \
# --project_id=$PROJECT_ID | tail -n1 | jq '.scan_id' | sed -e 's/^"//' -e 's/"$//'`
# sleep 20

# echo "Scan Report Uploaded Successfully, Scan Id:" $SCAN_ID