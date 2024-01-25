# Install Mosquitto MQTT Server in OpenShift

https://www.how2shout.com/linux/how-to-install-mosquitto-in-ubuntu-22-04-or-20-04-lts/

## Mosquitto Client 

sudo apt update
sudo add-apt-repository ppa:mosquitto-dev/mosquitto-ppa

sudo apt install mosquitto-clients


## Mosquitto Server+Client local 

sudo apt update
sudo add-apt-repository ppa:mosquitto-dev/mosquitto-ppa

sudo apt install mosquitto mosquitto-clients

## User+Password change
create/edit password.txt and add all userers using following format:
Username:Password 

mosquitto_passwd -U passwordfile

copy password.txt lines into the password.yaml section 

## Install Mosquitto Server in OpenShift

./create-mqtt.sh