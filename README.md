# archerysec=cli

archerysec-cli -s ${{ secrets.ARCHERYSEC_HOST }} -u ${{ secrets.ARCHERYSEC_USER }} -p ${{ secrets.ARCHERYSEC_PASS }} -t
          TOKEN_ID=`archerysec-cli -s ${{ secrets.ARCHERYSEC_HOST }} -u ${{ secrets.ARCHERYSEC_USER }} -p ${{ secrets.ARCHERYSEC_PASS }} -t`
          echo $TOKEN_ID

archerysec-cli -s https://archerysec.35.198.225.221.xip.io -u safe2008 -p xxxxxx -t
archerysec-cli -s ${ARCHERYSEC_HOST} -u ${ARCHERY_USER} -p ${ARCHERY_PASS} -t
TOKEN_ID=`archerysec-cli -s ${ARCHERYSEC_HOST} -u ${ARCHERY_USER} -p ${ARCHERY_PASS} -t`
echo $TOKEN_ID

archerysec-cli -s ${ARCHERYSEC_HOST} -u ${ARCHERY_USER} -p ${ARCHERY_PASS} --createproject \
          --project_name=${PROJECT_NAME} --project_disc=${PROJECT_DISC}  --project_start=${DATE} \
          --project_end=${DATE} --project_owner=${PROJECT_OWNER}

PROJECT_ID=`archerysec-cli -s ${ARCHERYSEC_HOST} -u ${ARCHERY_USER} -p ${ARCHERY_PASS} --createproject \
--project_name=$PROJECT_NAME --project_disc=$PROJECT_DISC  --project_start=$DATE \
--project_end=$DATE --project_owner=$PROJECT_OWNER | tail -n1 | jq '.project_id' | sed -e 's/^"//' -e 's/"$//'`
echo $PROJECT_ID

SCAN_ID=`archerysec-cli -s ${ARCHERYSEC_HOST} -u ${ARCHERY_USER} -p ${ARCHERY_PASS} --upload --file_type=XML \
--file=reports/dependency-check.xml --TARGET=$COMMIT_ID --scanner=dependencycheck \
--project_id=$PROJECT_ID | tail -n1 | jq '.scan_id' | sed -e 's/^"//' -e 's/"$//'`
echo $SCAN_ID

Git command to display HEAD commit id?
Use the command:

git rev-parse HEAD
For the short version:

git rev-parse --short HEAD
          
```bash
## https://medium.com/faun/practical-devops-continous-integration-with-git-vault-talisman-1b5ab046fcd9
##Installing Globally
##Pre-Commit Hook
curl --silent https://raw.githubusercontent.com/thoughtworks/talisman/master/global_install_scripts/install.bash > /tmp/install_talisman.bash && /bin/bash /tmp/install_talisman.bash

##Pre-Push Hook
curl --silent https://raw.githubusercontent.com/thoughtworks/talisman/master/global_install_scripts/install.bash > /tmp/install_talisman.bash && /bin/bash /tmp/install_talisman.bash pre-push

## Installing to a Single Project (by default installs as Pre-Push Hook)
curl https://thoughtworks.github.io/talisman/install.sh > ~/install-talisman.sh

truffleHog --regex --entropy=False https://github.com/dxa4481/truffleHog.git

truffleHog --regex --entropy=False https://github.com/tdg-analytics-platform/tdaa-service.git

```