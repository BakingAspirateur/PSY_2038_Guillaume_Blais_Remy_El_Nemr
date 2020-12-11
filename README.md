# PSY2038 - Travail final

Projet final d'une tâche visuelle de congruence dans le cadre du cours Programmation en neurosciences cognitives. 

## Fonctionnement

![alt text](https://i.ibb.co/R6CsJRc/bon-model.jpg)

Ce programme affiche des pairs images-mots. Une image est affichée, et une série de mots qui correspondent (ou pas) à l'image apparaissent à l'écran. Le programme demandera l'input du clavier. Si l'utilisateur ne rentre pas les touches désignées pour (in)congruence + exit key, le programme ne progressera pas. Dans le cas d'une mauvaise réponse (congruence quand ça ne l'est pas), le programme jouera un son d'erreur. Les données seront enregistrées dans un dossier à la fin du programme.

## Prérequis

Pour faire fonctionner le programme, vous aurez besoin de:

-[L'installation intégrale de Psychtoolbox](http://psychtoolbox.org/download). 

-MATLAB

-Microsoft Excel (Facultatif pour visionner les données hors de MATLAB).

## Installation

Il suffit de fork le repo, de le clone, et d'ouvrir le ficher Squelette.m dans MATLAB.

## Utilisation

Pour lancer le programme, il suffit d'entrer dans la console la ligne de code suivante:

`Squelette('NOM',TRIAL)`

*NOM* correspond au nom de votre participant.

*TRIAL* correspond au type de bloc - pour le bloc d'entrainement, **TRIAL = 0**. Pour le bloc d'essais, **TRIAL = 1.**

Par exemple, si le nom du participant est Maxime, et que vous voulez rouler le bloc d'essais, il vous suffira d'écrire:

`Squelette('maxime',1)`

## Contributeurs

[Guillaume Blais](https://github.com/BakingAspirateur)
[Rémy El-Nemr](https://github.com/RemyNmr)



