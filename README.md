
ARCHERYSEC_HOST=https://archerysec.35.198.225.221.xip.io
ARCHERY_USER=safe2008
ARCHERY_PASS=pass99word
PROJECT_NAME="DevSecOps"
PROJECT_DISC="DevSecOps Full pipeline"
PROJECT_OWNER="Boriphuth"
COMMIT_ID=`55555555555555`
DATE=`date +%Y-%m-%d`

export PROJECT_ID=`archerysec-cli -s ${ARCHERYSEC_HOST} -u ${ARCHERY_USER} -p ${ARCHERY_PASS} --createproject \
--project_name=${PROJECT_NAME} --project_disc=${PROJECT_DISC}  --project_start=${DATE} \
--project_end=${DATE} --project_owner=${PROJECT_OWNER} | tail -n1 | jq '.project_id' | sed -e 's/^"//' -e 's/"$//'`
echo $PROJECT_ID


archerysec-cli -s https://archerysec.35.198.225.221.xip.io -u safe2008 -p pass99word -t
archerysec-cli -s ${ARCHERYSEC_HOST} -u ${ARCHERY_USER} -p ${ARCHERY_PASS} -t

archerysec-cli -s ${ARCHERYSEC_HOST} -u ${ARCHERY_USER} -p ${ARCHERY_PASS} --createproject \
          --project_name=${PROJECT_NAME} --project_disc=${PROJECT_DISC}  --project_start=${DATE} \
          --project_end=${DATE} --project_owner=${PROJECT_OWNER}

          