# Cash-Manager

## Creez votre propre branche.

Une fois que vous avez finit de travailler sur une fonctionnalité et que vous souhaitez merge ne merge que sur la branch qui vous concerne.

Faites des bons commits pour vous y retrouvez. Vraiment c'est mieux.

Notre norme de commit : 

ADD/MOD/DEL : feature

ex: ADD: base flutter application
    MOD: update myButton feature
    DEL: remove old login page

Example : Je travaille sur le backend donc sur ma branche *mon-nom/feature*, quand je veux merge je push sur ma branche et fait un git merge origine/master. Je fais ensuite une pull request sur github de ma branche vers la branche master.

Essayons de garder Master le plus propre possible.

Hierarchie des branches : 
Master -> Backend -> vos branches personnelles.
Master -> Frontend -> vos branches personnelles.



______________________________________________________________

## Pense-bete Github:

_git branch *Nom de la branche* = Creer une branche._

_git checkout *Nom de la branche* = se rendre sur la branche._

_git add -u = ajouter uniquement les fichiers que vous avez modifiés._

_git commit -m "MESSAGE" : commentez votre travail._

_git push : envoyez votre travail_

__Commandes a utiliser avec attention :__

_git stash -m *message* = met vos modifications actuelles de COTÉ sans les suprimer._

_git stash list = vous permez de lister les stash ainsi que de voir le numéro de stash associé a votre message._

_git stash apply *numéro de stash* = recupérer le travail stash._

_git reset = retire les modifications que vous avez ADD sans les commits ( si vous souhaitez annuler en gros )_

_git merge *target branch* = vous permez de fusionner votre travail avec la branche._


______________________________________________________________
-> Trello
    https://trello.com/b/dzUG0JMw/cash-manager

