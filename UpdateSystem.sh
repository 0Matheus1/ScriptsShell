#!/bin/bash

#######################################################################
# UpdateSystem - script para automatizar processo de upgrade e update #
#								      #
# Autor: Matheus Siqueria (matheus.businessc@gmail.com)		      #
#								      #
# Exemplo de uso - ./UpdateSystem.sh				      #
#								      #
#######################################################################


figlet tst > /dev/null 2>&1
TESTFIGLET=$?

if [ $TESTFIGLET -ne 0 ] 
then
	echo "Necessário instalar o programa figlet" 
	read -p  "Proceder com a instalação? [y/n]" RESP

	if [ $RESP == y ] 
	then
		sudo apt-get install figlet
		sleep 1
		clear 
		figlet UpdateSystem
	else
		echo "Fechando programa..."
		sleep 2 
		exit 1
	fi
else
	figlet UpdateSystem
fi

echo "Carregando script..."
sleep 2 

echo "Atualizando sistema..."
sleep 2 

sudo apt upgrade
UPGR=$?
sudo apt update 
UPDT=$?

if [ $UPGR -eq 0 -a $UPDT -eq 0 ] 
then
	echo "Script executado com sucesso!" 
	exit 0
else
	echo "Erro na exucação do script" 
	exit 1
fi

