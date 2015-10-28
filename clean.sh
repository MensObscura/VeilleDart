echo '=====Clean====='
echo ''

echo '----------retablissement de votre bashrc----------'


if [ -f ~/.bashsave  ]; then
   rm -f ~/.bashrc  
   mv ~/.bashsave  ~/.bashrc
else
   echo "Vous avez déjà clean"
   exit
fi


echo '----------Suppression des pub install----------'

rm -rf ~/.pub-cache


echo '----------Suppression du repo VeilleDart en local----------'

rm -rf /local/$USER/VeilleDart

echo ''
echo "======Done======"
