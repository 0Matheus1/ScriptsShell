#!/bin/bash

####################################################################
# PythonInstall - script para instalação de dependências do python #
#								   #
# Autor: Matheus Siqueira (matheus.businessc@gmail.com) 	   #
#								   #
# Descrição: O script realiza instalação de dependências do python #
#	     para um processo de desenvolvimento completo	   #
# 								   #
# Exemplo de uso: ./PythonInstall.sh				   #
#								   #
####################################################################

figlet tst > /dev/null 2>&1
TESTFIGLET=$?

if [ $TESTFIGLET -ne 0 ]
then
	echo "Necessário instalar o programa figlet"
	read -p "Proceder com a instalação? [y/n]" RESP

	if [ $RESP == y -o $RESP == Y ]
	then
		sudo apt-get install figlet 
		sleep 1
		clear 
		figlet PythonInstall
	else
		echo "Fechando o programa..."
		sleep 2 
		exit 1
	fi
else
	figlet PythonInstall
fi

sudo apt upgrade
UPGR=$?
sudo apt update 
UPDT=$?

if [ $UPGR -eq 0 -a $UPDT -eq 0 ]
then
	sudo apt install git curl  

	sudo apt install python3.8 python3.8-dev python3.8-venv python3-venv python3-pip virtualenv gcc default-libmysqlclient-dev libssl-dev -y 

	sudo snap install pycharm-community --classic 
fi

if [ $? -eq 0 ] 
then 
	echo "Dependências instaladas com sucesso!"
	
	read -p "Reiniciar sistema agora? [Y/n]" RESP

	case $RESP in 
		[Yy])
			echo "Reiniciando..."
			sleep 2 
			shutdown -r now 
			;;
		[nN])
			echo "Go Code!" 
			exit 0
			;;
		*)
			echo "Opção inválida!"
			exit 1
			;;
	esac

fi

exit 0
