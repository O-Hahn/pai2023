#!/bin/bash
# Automatically deploy NR-Instances on OpenShift!

helpFunction()
{
   echo ""
   echo "Usage: $0 -i nr-instance-name -p project"
   echo -e "\t-i NodeRed Instance Name"
   echo -e "\t-p Project Namespace to be used"
   exit 1 # Exit script after printing help
}

while getopts "i:p:" opt
do
   case "$opt" in
      i ) NR_NAME="$OPTARG" ;;
      p ) NR_PROJECT="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

# Print helpFunction in case parameters are empty
if [ -z "$NR_NAME" ] || [ -z "$NR_PROJECT" ] 
then
   echo "Some or all of the parameters are empty";
   helpFunction
fi

# Begin script in case all parameters are correct
echo "Create NodeRed Instance: ${NR_NAME} in Project: ${NR_PROJECT}"

CHANGE_NAME="APP_NAME"
CHANGE_PROJECT="APP_PROJECT"

# Create temp directory for the deployment
if [ ! -d "tmp-deploy" ]; then
    echo "Create temp dir for deployment"
    mkdir -p "tmp-deploy"
fi


# create OpenShift Project
CREATE_PROJECT= `oc new-project ${NR_PROJECT}`
echo "  Create the Project... ${NR_PROJECT} $CREATE_PROJECT"

# Change the instance name of node-red in tmp-deploy
for s in nr-image-stream.yaml nr-pvc.yaml nr-deploy.yaml nr-service.yaml nr-route.yaml 
do
    # adopt yaml for deployment
    CHANGE_INSTANCE=`sed -e "s#${CHANGE_NAME}#${NR_NAME}#g" -e "s#${CHANGE_PROJECT}#${NR_PROJECT}#g" template\/${s} > tmp-deploy\/${s}`
    echo "  Creating adopted yaml: ${s} $CHANGE_INSTANCE" 

    # apply the yaml on OpenShift Instance
    CREATE_YAML=`oc create -f tmp-deploy\/${s}`
    echo "  Applying in OpenShift.. $CREATE_YAML"

    # copy adopted flow file to data 
    # oc cp MQTT-Test-Flow.json nr-1-xxxx:/data/flow.json

done

echo "--> DONE"