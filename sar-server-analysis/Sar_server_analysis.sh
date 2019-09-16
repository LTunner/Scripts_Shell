#!/bin/bash

echo -e "\e[1;31m ########## SISTEMA DE MONITORAMENTO E ANÁLISE ########## \e[0m"

cd
mkdir Spy_Monitoring_OPRAI
cd Spy_Monitoring_OPRAI
touch infotmp.txt


#Monitoramento SAR

function monitoramento_sar () {

  #CPU
  timeout -s2 1m sar -u ALL 1 > sarcpu_$(date +"%d%m%Y%H%M%S").txt &
  #CPU por Nucleo
  timeout -s2 1m sar -P ALL 3  > sarcpuN_$(date +"%d%m%Y%H%M%S").txt &
  #Memoria
  timeout -s2 1m sar -r 1 > sarmemory_$(date +"%d%m%Y%H%M%S").txt &
  # Memoria Swap
  timeout -s2 1m sar -S 1 > sarmemoryS_$(date +"%d%m%Y%H%M%S").txt &
  # Fluxo de Entrada e Saida
  timeout -s2 1m  sar -b 1 > sario_$(date +"%d%m%Y%H%M%S").txt &
  #Fila de execução e Média de Carga
  timeout -s2 1m  sar -q 1 > sarloadavarege_$(date +"%d%m%Y%H%M%S").txt &

  monitoramento_tmp


}

function monitoramento_tmp () {

  uso_tmp=$(df -h /tmp | awk {'print $5'})
  percentual=$(echo $uso_tmp | awk {'print $2'})
  echo $(date +"%d%m%Y%H%M%S")>>infotmp
  echo $percentual >>infotmp

}


function finalizar (){
	echo ""
	echo -e "\e[1;31m ########## Obrigado por utilizar o script de @ltunner! ########## \e[0m"
	echo -e ""
	sleep 3
	echo -n "Script fechando em:"
	sleep 1
	echo -n "  3"
	sleep 1
	echo -n "  2"
	sleep 1
	echo -n "  1"
	sleep 1
  echo -n Processo esta rodando, não abra os arquivos em 60 segundos.
	echo -n Finalizado em $(date +"%d/%m/%Y_%H:%M:%S")
}


monitoramento_tmp
monitoramento_sar
finalizar
