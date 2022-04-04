#!/bin/bash
#NAMESCRIPT=./AltService
figlet tst > /dev/null 2>&1
FIGLET=$?

if [ $FIGLET -ne 0 ]
then
	echo "Necessário instalar o programa figlet"
	read -p "Proceder com a instalação? [y/n] " RESP

	case $RESP in
		[yY])
			sudo apt-get install figlet
			sleep 1
			clear 
			figlet AltService
			;;
		*)
			echo "Finalizando script..." 
			sleep 1
			exit 1 
			;;
	esac
else 
	figlet AltService
fi

menu () {

	echo "Escolha uma opção: " 
	echo "[1] Habilitar Serviço"
	echo "[2] Desabilitar Serviço"
	echo "[3] Verificar Serviço"
	echo "[4] Descrição do Serviço"
	echo "[-h] Desligar máquina" 
	echo "[q] Sair"
}

rebootSystem(){

	systemctl reboot
}

menu 
read -p "Opção: " OPTION

case $OPTION in
	1)
		read -p "Informe o nome do serviço para habilita: " SERVICE

		STATUS=$(systemctl is-enabled $SERVICE)
		if [ $STATUS = enabled ]
		then
			echo "O Serviço já está habilitado!" 
			sleep 1
		else
			sudo systemctl enable $SERVICE
			read -p "Reiniciar o sistema agora? [y/n]" RESP
			case $RESP in
				[yY])
					echo "Reiniciando sistema..."
					sleep 2
					rebootSystem
					;;
				[nN])
					clear 
					menu
					;;
				*)
					echo "Opção inválida!"
					exit 1
					;;
			esac
		fi
		;;
	2)
		read -p "Informe o nome do serviço para desabilitar: " SERVICE
		STATUS=$(systemctl is-enabled $SERVICE)
		if [ $STATUS = disabled ] 
		then 
			echo "O serviço $SERVICE já está desabilitado." 
			sleep 1 
		else
			sudo systemctl disable $SERVICE
		fi
		;;
	3)
		read -p "Informe o nome do serviço para verificar: " SERVICE
		echo $(systemctl is-enabled $SERVICE)
		;;
	4)
		read -p "Informe o nome do serviço: " SERVICE 
		echo $(systemctl cat $SERVICE)
		;;
	[qQ])
		echo "Saindo..."
		sleep 2 
		exit 0
		;;
	-h)
		echo "Desligando máquina..."
		sleep 2
		shutdown -h now 
		;;
	*)
		echo "Opção inválida!"
		exit 1
		;;
esac

	read -p "Realizar outro processo? [s/n] " ANS

	if [ $ANS = S -o $ANS = s ]
	then
		echo "[OK] Reiniciando script..."
		sleep 1
		clear 
		./AltService.sh
	elif [ $ANS = N -o $ANS = n ]
	then
		echo "Saindo..."
		exit 0
	else 
		echo "Opção inválida!"
		exit 1
	fi

exit 0 	
