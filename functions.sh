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

validate_ip() {
    local ip=$1
    local stat=1

    if [[ $ip =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
        IFS='.' read -r -a ip_array <<< "$ip"
        [[ ${ip_array[0]} -le 255 && ${ip_array[1]} -le 255 && ${ip_array[2]} -le 255 && ${ip_array[3]} -le 255 ]]
        stat=$?
    fi

    return $stat
}

validate_port() {
    local port=$1
    [[ "$port" =~ ^[0-9]+$ ]] && [[ $port -ge 1 && $port -le 65535 ]]
}

prompt_ip_port() {
    while true; do
        read -p "  Enter attacker IP address: " attackerip
        # Simple IP validation regex (basic)
        if [[ $attackerip =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
            break
        else
            echo "  Invalid IP address format. Please try again."
        fi
    done

    while true; do
        read -p "  Enter attacker port (1-65535): " attackerport
        if [[ $attackerport =~ ^[0-9]+$ ]] && (( attackerport > 0 && attackerport <= 65535 )); then
            break
        else
            echo "  Invalid port number. Please enter a number between 1 and 65535."
        fi
    done
}
#########################################
#----------------- VARS ----------------#
#########################################
read -r ADDR <<< "$(ip -o -f inet addr show tun0 2>/dev/null | while read -r _ _ _ ip _; do echo "${ip%%/*}"; done)"
read -r EADDR <<< "$(ip -o -f inet addr show eth0 2>/dev/null | while read -r _ _ _ ip _; do echo "${ip%%/*}"; done)"
read -r WADDR <<< "$(ip -o -f inet addr show wlan0 2>/dev/null | while read -r _ _ _ ip _; do echo "${ip%%/*}"; done)"
wdir=$(pwd)
THISIP=$(dig @resolver4.opendns.com myip.opendns.com +short -4)

###########################################
#---------------  Colors  ----------------#
###########################################

C=$(printf '\033')

# Foreground + Background Colors
FGR="${C}[48;5;196m"        # Red BG
FGG="${C}[48;5;22m"         # Green BG
FGB="${C}[48;5;34m"         # Blue BG
FGC="${C}[48;5;237m"        # Gray BG

# Standard Foreground Colors
RED="${C}[1;31m"
GREEN="${C}[1;32m"
YELLOW="${C}[1;33m"
BLUE="${C}[1;34m"
LIGHT_MAGENTA="${C}[1;95m"
LIGHT_CYAN="${C}[1;96m"
LG="${C}[1;37m"
DG="${C}[1;90m"

# SED-style Highlight Colors
SED_RED="${RED}&${C}[0m"
SED_GREEN="${GREEN}&${C}[0m"
SED_YELLOW="${YELLOW}&${C}[0m"
SED_RED_YELLOW="${C}[1;31;103m&${C}[0m"
SED_BLUE="${BLUE}&${C}[0m"
SED_LIGHT_MAGENTA="${LIGHT_MAGENTA}&${C}[0m"
SED_LIGHT_CYAN="${LIGHT_CYAN}&${C}[0m"
SED_LG="${LG}&${C}[0m"
SED_DG="${DG}&${C}[0m"

# Text Styles
UNDERLINED="${C}[4m"
ITALIC="${C}[3m"
ITALIC_BLUE="${BLUE}${ITALIC}"

# Reset
NC="${C}[0m"

###############################################
#  LOCAL ADAPTER ADDRESSES
###############################################
if [ "$(whoami)" = "root" ]; then
    ICON="${FGC}${RED}🔥"
else
    ICON="${FGB}${GREEN}👽"
fi

ME="${ICON}  $(whoami)@$(hostname) ${NC}"
# Optionally uppercase everything
# ME=$(echo "$ME" | tr '[:lower:]' '[:upper:]')

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

#    echo "               | IPV4: $THISIP"| sed 's/$/ /g'   ## Uncomment this if you want to show your ipv4 public ip address in dialogs
    echo "               -------------------------------------"
    return 
}

###############################################
# SHOW ERRORS
###############################################
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

###############################################
#  FILE CHOOSER 
###############################################
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

###############################################
#  EXIT 1
###############################################

goodbye()
{
  echo  "${YELLOW}	  |${FGG}    👋${GREEN}            Goodbye            👋      ${NC}${YELLOW}|"
  echo
  echo
  exit 0;
}

###############################################
# EXIT 0
###############################################

badbye()
{
  echo  "${RED}	  |${FGR}💀${LG}            FATAL ERROR!!             💀 ${NC}${RED}|"
  echo 
  echo
  exit 1;
}


###############################################
# LAUNCH IN MSFCONSOLE
###############################################

launch_msfconsole() {
    local rcfile="$1"

    # Check for xterm first
    if command -v xterm >/dev/null 2>&1; then
        xterm -e msfconsole -r "$rcfile"
        return
    fi

    # Try other popular terminal emulators
    if command -v gnome-terminal >/dev/null 2>&1; then
        gnome-terminal -- msfconsole -r "$rcfile"
        return
    fi

    if command -v konsole >/dev/null 2>&1; then
        konsole -e msfconsole -r "$rcfile"
        return
    fi

    if command -v xfce4-terminal >/dev/null 2>&1; then
        xfce4-terminal -e "msfconsole -r $rcfile"
        return
    fi

    if command -v terminator >/dev/null 2>&1; then
        terminator -x msfconsole -r "$rcfile"
        return
    fi

    if command -v kitty >/dev/null 2>&1; then
        kitty msfconsole -r "$rcfile"
        return
    fi

    # If no GUI terminal emulator found, fallback to running msfconsole directly
    echo -e "\n${YELLOW}⚠️  No graphical terminal emulator found. Running msfconsole in current terminal.${NC}"
    msfconsole -r "$rcfile"
}

###############################################
# RUN MSF MODULE
###############################################


run_msf_module() {
    local module_path="$1"
    local session_id="$2"
    shift 2
    local extra_params=("$@")

    # Temporary resource file for the module commands
    local rcfile="$wdir/msf_module.rc"

    # Start resource file with 'use' and set session
    {
        echo "use $module_path"
        echo "set SESSION $session_id"
        # Add any extra parameters provided
        for param in "${extra_params[@]}"; do
            echo "set $param"
        done
        echo "run"
    } > "$rcfile"

    echo -e "${GREEN}[*] Running Metasploit module '$module_path' on session $session_id...${NC}"

    # Inject resource file into tmux msf session
    tmux send-keys -t msf "resource $rcfile" Enter
}


