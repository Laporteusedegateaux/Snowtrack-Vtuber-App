# SnowTrack - Une application Open source pour vtuber, faite sous Godot
[English version of this Readme here!](README.md)
## Quel est ce projet ?
Ceci est un projet d'application open-source faite par des vtubers, pour les vtubers.
C'est pour le moment une base qui sera utile à un niveau intermédiaire voire avancé, et sera agrandie pour être rendue plus intuitive au fil du temps.

Vous pouvez modifier tout ce qui est fourni ici!
Une fonctionalité vous manque ? Tu peux la coder toi-même, ou en parler !

## Qu'est-ce qui est actuellement fonctionnel ?
Pas grand-chose ! Ce logiciel est pour le moment plus une base, donc une certaine quantité de travail est nécessaire pour l'utiliser.
Voici ce qui est disponible :
- Tracking Arkit (IFacialMocap ou Meowface)
- Intégration Twitch pour le chat, les récompenses, bits, subs, trains de la hype, follow, etc.
- Tracking des mains (Cassé actuellement, mais ça track techniquement bien les mains... Mais pas bien)
- Différents angles de caméra et un changement facile entre eux

## Qu'est-ce qui est prévu ?
Je veux ajouter une pléthore de fonctionnalités au fil du temps. Pour le moment, voici celles auquelles je pense :
- Charger des avatars directement depuis un fichier blender avec un setup intégré
- Charger des décors et objets directement depuis un fichier, et les placer/modifier sans avoir à les convertir à un autre format
- Plus d'options de tracking comme les webcam, kinect et mediapipe
- Pouvoir se déplacer dans vos environnements
- Avoir des paramètres et options dans une fenêtre séparée
- La possibilité d'utiliser l'application depuis un autre PC pour éviter une charge graphique de plus sur un pc de stream
- Support des avatars Live2D
- Support des avatars PNG

Et probablement beaucoup plus. Une fonctionnalité vous manque ? On peut l'ajouter à la liste !

## Problèmes connus et limitations
Pour le moment, voici ce que je sais cassé. Ce projet est encore très jeune - les bugs et les fonctionnalités non finies sont à prévoir.
Voici donc :
- La seule option pour le tracking est actuellement ARKit. IfacialMocap (Iphone) et Meowface (Android) fonctionnent tout deux.
- Il n'y a pas de façon simple d'importer un avatar - vous devez faire le paramétrage vous-mêmes. J'aurais des guides en ligne dans le futur proche.
- Seuls les avatars 3D sont supportés actuellement.
- Le code n'est pas toujours très optimisé - Désolée, je fais de mon mieux. ^^'

## Rendons à César ce qui est à César - Crédits
Ce projet repose sur plusieurs addons open source réalisés par d'autres personnes.
Donc, merci et crédit à ces super projets !
- [Wigglebones](https://github.com/Laporteusedegateaux/godot-wigglebones) par Bauxitedev, Yaelatletl, Cory Petkovsek et moi-même
- [Phantom Camera](https://github.com/ramokz/phantom-camera) par Ramokz
- [GlobalInput](https://github.com/Darnoman/Godot-GlobalInput-Addon) par Darnoman
- [TMI](https://github.com/erodozer/tmi.gd) par Erodozer
- [Ultraleap godot addon](https://forge.lunai.re/rodolphe/godot-ultraleap-plugin) par Rodolphe
- [Jolt for Godot](https://github.com/godot-jolt/godot-jolt) par... Godot Jolt
