#!/bin/sh

# this script installs clevertagger and Zmorge, and configures ParZu to use them.

# get clevertagger
mkdir -p external
git clone https://github.com/rsennrich/clevertagger external/clevertagger

# get Wapiti and compile it
git clone https://github.com/rsennrich/Wapiti external/Wapiti
cd external/Wapiti
make
cd ../..

# get models
cd external
wget -c http://kitt.ifi.uzh.ch/kitt/zmorge/transducers/zmorge-20140521-smor_newlemma.ca.zip
wget -c http://kitt.ifi.uzh.ch/kitt/zmorge/models/hdt_ab.zmorge-20140521-smor_newlemma.model.zip
unzip -u zmorge-20140521-smor_newlemma.ca.zip
unzip -u hdt_ab.zmorge-20140521-smor_newlemma.model.zip
cd ..

SCRIPTPATH=`cd $(dirname "$SCRIPT") && pwd`

# configure clevertagger
sed -i "s,^SMOR_MODEL =.*$,SMOR_MODEL = '$SCRIPTPATH/external/zmorge-20140521-smor_newlemma.ca'," external/clevertagger/config.py
sed -i "s,^CRF_MODEL =.*$,CRF_MODEL = '$SCRIPTPATH/external/hdt_ab.zmorge-20140521-smor_newlemma.model'," external/clevertagger/config.py
sed -i "s,^CRF_BACKEND_EXEC =.*$,CRF_BACKEND_EXEC = '$SCRIPTPATH/external/Wapiti/wapiti'," external/clevertagger/config.py

# configure ParZu
sed -i "s,^smor_model =.*$,smor_model = $SCRIPTPATH/external/zmorge-20140521-smor_newlemma.ca," config.ini
sed -i "s,^taggercmd =.*$,taggercmd = $SCRIPTPATH/external/clevertagger/clevertagger," config.ini
