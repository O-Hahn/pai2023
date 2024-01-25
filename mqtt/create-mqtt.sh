oc delete project mqtt
sleep 20
oc new-project mqtt

oc apply -k . 