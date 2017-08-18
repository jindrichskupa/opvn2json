#!/bin/bash

STATUS=$@

function parse_section(){
  case $1 in
    CLIENT_LIST)
      grep ^CLIENT_LIST $STATUS | awk 'BEGIN{ printf "\"clients\":{\n"}
           {printf "\t\""$2"\":\n\t\t{\"address\": \""$3"\", \"vpn_address\":\""$4"\", \"net_in\": "$5", \"net_out\": "$6", \"since\": "$12"},\n"}' | \
           awk '{a[NR]=$0} END {for (i=1;i<NR;i++) print a[i];sub(/.$/,"\n\t},",a[NR]);print a[NR]}'
    ;;
    ROUTING_TABLE)
      grep ^ROUTING_TABLE $STATUS | awk 'BEGIN{printf "\"routes\":{\n"}
           {printf "\t\""$3"\":\n\t\t{ \"vpn_address\": \""$2"\", \"client\": \""$3"\", \"address\":\""$4"\", \"since\": "$10"},\n";}' | \
           awk '{a[NR]=$0} END {for (i=1;i<NR;i++) print a[i];sub(/.$/,"\n\t}",a[NR]);print a[NR]}'
    ;;
    TITLE)
      grep ^TITLE $STATUS | sed 's/  / /g' | awk '{ print "\"info\":\""substr($0, index($0,$2))"\"," }'
    ;;
    *)
      /bin/true
    ;;
  esac
}

echo '{'
for section in TITLE CLIENT_LIST ROUTING_TABLE; do
	parse_section $section
done
echo '}'
