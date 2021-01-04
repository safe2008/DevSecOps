#!/bin/sh

sudo wget -O ${SCA_PATH} ${SCA_URL} --quiet
sudo unzip -q -o ${SCA_PATH} -d /opt/
export PATH=/opt/dependency-check/bin:$PATH
sudo bash /opt/dependency-check/bin/dependency-check.sh --project ${PROJECT_NAME} --scan . -f XML --out reports/dependency-check-report.xml

cat odc-reports/dependency-check-report.xml
sudo apt-get install jq
sudo pip install archerysec-cli

DATE=`date +%Y-%m-%d`

# create project in archerysec
PROJECT_ID=`archerysec-cli -s ${{ secrets.ARCHERYSEC_HOST }} -u ${{ secrets.ARCHERYSEC_USER }} -p ${{ secrets.ARCHERYSEC_PASS }} --createproject \
--project_name=$PROJECT_NAME --project_disc=$PROJECT_DISC  --project_start=$DATE \
--project_end=$DATE --project_owner=$PROJECT_OWNER | tail -n1 | jq '.project_id' | sed -e 's/^"//' -e 's/"$//'`
echo $PROJECT_ID

# Upload Scan report in archerysec
# SCAN_ID=`archerysec-cli -s ${{ secrets.ARCHERYSEC_HOST }} -u ${{ secrets.ARCHERYSEC_USER }} -p ${{ secrets.ARCHERYSEC_PASS }} --upload --file_type=XML \
# --file=odc-reports/dependency-check-report.xml --TARGET=$GITHUB_SHA --scanner=dependencycheck \
# --project_id=$PROJECT_ID | tail -n1 | jq '.scan_id' | sed -e 's/^"//' -e 's/"$//'`
# sleep 20

# echo "Scan Report Uploaded Successfully, Scan Id:" $SCAN_ID