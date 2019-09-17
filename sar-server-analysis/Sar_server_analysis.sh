#!/bin/bash

echo -e "\e[1;31m ########## SISTEMA DE MONITORAMENTO E ANÁLISE ########## \e[0m"

cd
mkdir Spy_Monitoring_OPRAI
cd Spy_Monitoring_OPRAI
echo -n Script Inializado em $(date +"%d/%m/%Y_%H:%M:%S")

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
	echo -e "\e[1;31m ########## Obrigado por utilizar o script do Sr. Luciano Tunner! ########## \e[0m"
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
  echo -e Finalizado em $(date +"%d/%m/%Y_%H:%M:%S")
}

monitoramento_sar
sleep 60
monitoramento_tmp
finalizar



#Informações do Script

# timeout -s2 (tempo)  = Esse comando informar faz com que comandos parem de ser executados em um tempo especifico, e sendo encerrado com o Signal 2, como o encerrar do Ctrl+C.
# $(date +"%d/%m/%Y_%H:%M:%S") = Traz a informação de dia/mes/ano hora:minuto:segundo sequencialmente
# Os comandos Sar podem ser encontrados facilmente executando o comando no terminal. $ man sar
# Sleep = Serve para dar um time antes de executar um comando posterior, no nosso caso a função monitoramento_tmp
# Outros comandos para esse arquivo são menos relevantes, mas em caso de duvidas, favor entrar em contato nas redes sociais ou telegram @ltunner
