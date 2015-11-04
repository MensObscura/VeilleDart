# Chat Dart

##Description
Ce répo contient l'application vitrine de notre veille techno, un chat multi-channel réalisé en Dart à l'aide de WebSocket.
La suite de ce ReadMe est l'énoncé du TP.

## Déroulement de la séance

### Préparation et configuration de l'environnement de dev

Pour exécuter du code Dart (en mode console), vous aurez besoin de la VM Dart, un binaire exécutable qu'il suffit de lancer de la sorte :
* *dart fichier.dart* 

Pour pouvoir interpréter du Dart dans une page HTML, il faut cette fois ci que le navigateur intègre la VM Dart. A ce jour, seul Dartium (un fork de Chromium) la propose. Il faudra donc impérativement utiliser Dartium dès lors que vous aurez à travailler avec des pages HTML.

### Installation de Dart et Dartium

Pour vous simplifier la vie et éviter de perdre du temps inutilement, nous avons préparer un script **start.sh** qu'il vous suffit de lancer (après avoir attribué les droits "*chmod 700 start.sh*" ). Le script ira automatiquement télécharger les binaires de la VM Dart et de Dartium dans le **local** de votre machine (on est sympa avec votre quota, nous).
Il vous ajoutera en prime les exports et alias nécessaires dans votre bashrc (une copie de backup est réalisée, pas de panique)  pour lancer la VM et le navigateur depuis n'importe où dans un terminal via les commandes : **dart** et **dartium**.

A la fin de la séance, utilisez le script clean.sh pour supprimer tout ce qui a été téléchargé et remettre votre bashrc dans l'état initial. 

Pour ceux qui voudraient travailler sur leur machines et qui sont sous environnement Unix, vous pouvez utilsez le script il faudra juste au préalable ajouter un répertoire "**/local/votre_username**" à la racine de votre disque.

Pour les autres, vous pouvez récupérer manuellement pour linux : la VM Dart  https://storage.googleapis.com/dart-archive/channels/dev/release/1.13.0-dev.7.6/sdk/dartsdk-linux-x64-release.zip
et Dartium https://storage.googleapis.com/dart-archive/channels/dev/release/1.13.0-dev.7.6/dartium/dartium-linux-x64-release.zip

pour Windows : https://storage.googleapis.com/dart-archive/channels/dev/release/1.13.0-dev.7.6/sdk/dartsdk-windows-x64-release.zip et
https://storage.googleapis.com/dart-archive/channels/dev/release/1.13.0-dev.7.6/dartium/dartium-windows-ia32-release.zip

et pour Mac :

https://storage.googleapis.com/dart-archive/channels/dev/release/1.13.0-dev.7.6/sdk/dartsdk-macos-x64-release.zip
et
https://storage.googleapis.com/dart-archive/channels/dev/release/1.13.0-dev.7.6/dartium/dartium-macos-ia32-release.zip

**/!\ IMPORTANT /!\** Sous linux un problème récurent appraît avec Dartium, il faut rajouter le lien symbolique suivant :
*  *sudo ln -n /lib/x86_64-linux-gnu/libudev.so.1 /lib/x86_64-linux-gnu/libudev.so.0*

Pour les autres OS (ou les distributions linux autres que basées sur Debian) et pour qui le lien ne fonctionnerait pas, Google devrait vous aider. La manipulation a été faite sur l'ensemble des postes de la salle, donc travaillez sur votre machine ça reste le plus simple. 


### TP

Le TP se décompose en 2 parties, une première partie avec deux exercices à réaliser depuis l'éditeur DartPad directement en ligne. La seconde partie consistera à améliorer notre application de chat en local sur votre machine.

#### 1/ Exercices

Nous avons réalisé deux mini-applications, *un Devin (+ ou -)* et une *ToDo list* pour vous familiariser avec Dart et axé autour de la manipulation du DOM.
Nous vous fournissons les pages HTML ainsi que les squelettes en Dart que vous aurez à compléter.
(La fiche de synthèse contient la liste des fonctions Dart essentielles dont vous aurez besoin)

 Tout d'abord rendez vous sur ces deux liens afin de vous familiariser avec la syntaxe Dart :
 * Devin : https://dartpad.dartlang.org/f9e34cdfb28e7098b18a 
 * ToDo List : https://dartpad.dartlang.org/3a3be729394c3d31c380
 

 
#### 2/ Amélioration du chat

 Une fois ces exercices réalisés, vous pourrez implémenter différentes améliorations à notre application de Chat :
 
 **/!\ Afin de préserver la bonne intégrité du serveur (svp), cette partie sera à réaliser localement sur votre machine, via le répertoire prêt à l'emploi "*web_local*."**
  
 * Stocker l'historique des conversations d'un channel afin de les voir lorsque l'on switch de channel. 
 * Ajouter la possibilité de supprimer un channel. 
 * Enfin ajouter le code nécéssaire à l'envoi de messages privés avec la syntaxe "/username", le message qui suivra ne sera visible que par la personne ciblée, si celle-ci se trouve sur le channel de l'expéditeur.

