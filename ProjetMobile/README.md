# Projet Mobile Flutter
LEPEU Marion - HOFF Tom - MABILLE Thomas

# /!\ IMPORTANT /!\
Il se peut qu'au démarrage du projet les requêtes vers l'API Web Steam n'aboutissent pas. Pour pallier ce problème il faut demander une démo CORS via ce lien : https://cors-anywhere.herokuapp.com/corsdemo et simplement cliquer sur 'Request temporary access to the demo server'.
Cela devrait débloquer les accès et nous permettre d'afficher les informations.

Ce projet à pour but de nous faire développer une application mobile en flutter permettant à un utilisateur d'indiquer quels sont ses jeux vidéos favoris à travers l'API de Steam.
Les informations de chaque utilisateur (username, email, mot de passe, likes, wishlist) sont stocké sur Firebase et Firestore. Nous effectuons des requêtes vers ces bases pour récupérer les informations de connexion et les listes de jeux souhaités et likés. 
Pour les listes likes/wishlist nous stockons les steam_appid des jeux afin de pouvoir afficher leurs détails via une requête vers l'api steam de détails des jeux.

# Screenshot de firebase
<img width="927" alt="firebase" src="https://user-images.githubusercontent.com/91416520/224542302-95845b87-f5be-4535-a490-1d12022d5b17.png">

# Screenshot du cloud_firestore
<img width="917" alt="cloud_firestore" src="https://user-images.githubusercontent.com/91416520/224542346-c327a7d1-b372-462f-a929-91ad9faa94f7.png">
