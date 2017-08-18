# opvn2json

## Usage:

### Clone repository

```bash
$ git clone https://github.com/jindrichskupa/ovpn2json.git
```

### Turn on and set status file format in server config

```
status-version 3
status /var/run/openvpn/server.status 10
```
 
### Render json from single or multiple status file
  
```bash
$ ./ovpn2json.sh /var/run/openvpn/server01.status
$ ./ovpn2json.sh /var/run/openvpn/server01.status /var/run/openvpn/server02.status
$ ./ovpn2json.sh /var/run/openvpn/*.status  
 ```

### Query with jq

```bash
$ ./ovpn2json.sh /var/run/openvpn/server01.status | jq '.clients.client1.address'
"1.1.1.1:1194"
$ ./ovpn2json.sh /var/run/openvpn/server01.status | jq '.clients.client1.vpn_address'
"10.0.0.10"
```

## Example output

```json
{
  "info": "OpenVPN 2.3.4 x86_64-pc-linux-gnu [SSL (OpenSSL)] [LZO] [EPOLL] [PKCS11] [MH] [IPv6] built on Nov 12 2015",
  "clients": {
    "client1": {
      "address": "1.1.1.1:61174",
      "vpn_address": "10.0.0.12",
      "net_in": 14850,
      "net_out": 8086,
      "since": 1503051730
    },
    "client2": {
      "address": "1.1.1.1:5001",
      "vpn_address": "10.0.0.49",
      "net_in": 1245612333,
      "net_out": 953096800,
      "since": 1502929800
    }
  },
  "routes": {
    "client1": {
      "vpn_address": "aa:bb:cc:dd:ee:ff",
      "client": "client1",
      "address": "1.1.1.1:61174",
      "since": 1503051749
    },
    "client2": {
      "vpn_address": "10.0.0.49",
      "client": "client2",
      "address": "1.1.1.1:5001",
      "since": 1503051786
    }
  }
}
```

