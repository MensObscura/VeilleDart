

cat dart.txt

echo '==== Hello ===='
echo ''

if [ -f ~/.bashrc  ]; then
    echo ".bashrc found"
else
    touch ~/.bashrc
    echo ".bashrc created"
fi

if [ -f ~/.bashsave  ]; then
    echo "Vous avez déjà start"
else
  

echo '----------saving your current .bashrc----------'

cp -v ~/.bashrc ~/.bashsave

echo '----------Recuperation de DART SDK------------'

wget https://storage.googleapis.com/dart-archive/channels/dev/release/1.13.0-dev.7.3/sdk/dartsdk-linux-x64-release.zip

echo '----------Decompression dans votre fichier local----------'

mkdir /local/$USER/VeilleDart

unzip dartsdk-linux-x64-release.zip -d /local/$USER/VeilleDart

rm -f dartsdk-linux-x64-release.zip

echo '----------Export dans PATH dart/bin---------'

export  PATH=$PATH:/local/$USER/VeilleDart/dart-sdk/bin
echo "export  PATH='$PATH:/local/$USER/VeilleDart/dart-sdk/bin'" >> ~/.bashrc


echo '----------Pub install stagehand---------'

pub global activate stagehand

echo '----------Export dans PATH pub/bin---------'

export PATH=$PATH:~/.pub-cache/bin
echo "export PATH='$PATH:~/.pub-cache/bin'" >> ~/.bashrc

echo '----------Création de la commande dart----------'

echo "alias dart='/local/$USER/VeilleDart/dart-sdk/bin/dart'" >> ~/.bashrc


echo '----------Recuperation de DARTIUM----------'

wget https://storage.googleapis.com/dart-archive/channels/dev/release/1.13.0-dev.7.3/dartium/dartium-linux-x64-release.zip


echo '----------Decompression dans votre fichier local----------'

unzip dartium-linux-x64-release.zip -d /local/$USER/VeilleDart

rm -f dartium-linux-x64-release.zip 

mv /local/$USER/VeilleDart/dartium-lucid64-full-dev-1.13.0-dev.7.3.0 /local/$USER/VeilleDart/dartium

echo '----------Création de la commande dartium----------'


echo "alias dartium='/local/$USER/VeilleDart/dartium/chrome &'" >> ~/.bashrc



echo ''
echo "======Done======"

fi

echo "Veuillez relancer un terminal"
echo "ou executer la commande suivante : source ~/.bashrc"

exit
