#!/bin/bash
# Create all needed instances for PAI students

NR_NAME_PREFIX="node-red"

helpFunction()
{
   echo ""
   echo "Usage: $0 -n number-of-nodered-instances"
   echo -e "\t-n NodeRed Instance Name"
   exit 1 # Exit script after printing help
}

while getopts "n:" opt
do
   case "$opt" in
      n ) NUMBER="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

# Print helpFunction in case parameters are empty
if [ -z "$NUMBER" ]  
then
   echo "Some or all of the parameters are empty";
   helpFunction
fi

for i in $(seq 1 $NUMBER)
do
    # define instance name
    value=$(printf "%02d" $i)
    instance="$NR_NAME_PREFIX"-"$value"
    echo $instance

    # create nr-instance with the new name
    CREATE_YAML=`create-nr -i ${instance} -p ${instance}` 
    echo "  Creating Instance in OpenShift.. $CREATE_YAML"
    
done

