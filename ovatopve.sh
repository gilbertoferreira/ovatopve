#!/bin/bash

clear
echo "========================================================="
echo "|							|"
echo "|       Programa para converter ova para Proxmox	|"
echo "|							|"
echo "========================================================="
echo ""
clear
Menu() {
echo "Escolha abaixo ..."
echo ""
echo "[ 0 ] - Onde está o arquivo OVA?"
echo "[ 1 ] - VMWare"
echo "[ 2 ] - HyperV"
echo "[ 3 ] - VirtualBox"
echo "[ 4 ] - Sair"
echo ""

echo "Digite sua opção:"; read opcao
case $opcao in
	0) onde ;;
	1) vmware ;;
	2) hyperv ;;
	3) vbox ;;
	4) exit ;;
	*) echo "Opção desconhecida" ; sleep 1;clear; Menu
esac
}

onde(){
	clear
	echo ""
	echo "Digite o caminho onde está o arquivo"
	read caminho
	for arquivo in `ls $caminho`; do
	echo "Achei o arquivo $arquivo"
	echo "Vamos descompacta-lo..."
	echo "Deseja prosseguir? (S/N)"
	read op2 
 	if [ $op2 == "S" ];
	then 
		echo "Renomeando o arquivo $arquivo para .tar"
		cd $caminho
		mv "$arquivo" "$(basename "$arquivo" .ova).tar"
		sleep 2
		echo "Descompacando..."
	for arqtar in `ls $caminho`;do
		cd $caminho
		tar xvf "$arqtar"
		echo "Operação concluida..."
		echo "Retornando..."
		clear
		Menu
	done
	else
		echo "Voltando ao menu principal"
		clear
		Menu
	fi
	done
Menu
}

vmware(){
	clear
	echo ""
	echo "Digite o caminho onde está o arquivo"
	read caminho
	for arquivo in `ls $caminho/*.vmdk`; do
		if [[ $arquivo == *.vmdk ]];
		then
			echo "É um arquivo VMDK..."
			sleep 1
			echo "Criando uma VM no Proxmox com VMID 999..."
echo "Não esqueça de renomear o ID da VM depois, pra refletir seu ambiente e ajustar a VM..."
			echo "Mostrando os storages disponíveis..."
		pvesm status
			echo ""
			echo "Escolhe o storage desejado..."
			read stg
			echo ""
			echo ""
echo "Criando a VM 999..."			
qm create 999 --net0 virtio,bridge=vmbr0 --name vm999 --serial0 socket --bootdisk scsi0 --scsihw virtio-scsi-pci --ostype win10
qm importdisk 999 $arquivo $stg	
echo ""
sleep 2
echo "Importação foi um sucesso..."
sleep 2
echo "Não esqueça de ajustar a VM 999 para suas necessidades..."
clear
		else
			echo "Não é um arquivo VMDK..."
		fi
done
Menu
}

hyperv(){
	clear
	echo ""
	echo "Lembre-se que esse script trabalha com arquivo vhdx... Por favor renomeie..."
	echo "Digite o caminho onde está o arquivo"
	read caminho
	for arquivo in `ls $caminho/*.vhdx`; do
		if [[ $arquivo == *.vhdx ]];
		then
			echo "É um arquivo VHDX..."
			sleep 1
			echo "Criando uma VM no Proxmox com VMID 999..."
echo "Não esqueça de renomear o ID da VM depois, pra refletir seu ambiente e ajustar a VM..."
			echo "Mostrando os storages disponíveis..."
		pvesm status
			echo ""
			echo "Escolhe o storage desejado..."
			read stg
			echo ""
			echo ""
echo "Criando a VM 999..."			
qm create 999 --net0 virtio,bridge=vmbr0 --name vm999 --serial0 socket --bootdisk scsi0 --scsihw virtio-scsi-pci --ostype win10
qm importdisk 999 $arquivo $stg	
echo ""
sleep 2
echo "Importação foi um sucesso..."
sleep 2
echo "Não esqueça de ajustar a VM 999 para suas necessidades..."
clear
		else
			echo "Não é um arquivo VHDX..."
		fi
done
Menu
}

vbox(){
	clear
	echo ""
	echo "Digite o caminho onde está o arquivo"
	read caminho
	for arquivo in `ls $caminho/*.vdi`; do
		if [[ $arquivo == *.vdi ]];
		then
			echo "É um arquivo VDI..."
			sleep 1
			echo "Criando uma VM no Proxmox com VMID 999..."
echo "Não esqueça de renomear o ID da VM depois, pra refletir seu ambiente e ajustar a VM..."
			echo "Mostrando os storages disponíveis..."
		pvesm status
			echo ""
			echo "Escolhe o storage desejado..."
			read stg
			echo ""
			echo ""
echo "Criando a VM 999..."			
qm create 999 --net0 virtio,bridge=vmbr0 --name vm999 --serial0 socket --bootdisk scsi0 --scsihw virtio-scsi-pci --ostype win10
qm importdisk 999 $arquivo $stg	
echo ""
sleep 2
echo "Importação foi um sucesso..."
sleep 2
echo "Não esqueça de ajustar a VM 999 para suas necessidades..."
clear
		else
			echo "Não é um arquivo VMDK..."
		fi
done
Menu
}

Menu
