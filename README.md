# dart_scripthash_generator_server
[![Dart](https://github.com/willyfromtheblock/dart_scripthash_generator/actions/workflows/dart.yml/badge.svg)](https://github.com/willyfromtheblock/dart_scripthash_generator/actions/workflows/dart.yml)  
Simple command line tool to generate Electrum scripthashes from addresses.
Based on [coinslib](https://github.com/Vesta-wallet/coinslib/ "coinslib").

### Prerequisites
- Dart

### Example
Simply provide the desired network and address as arguments:

`dart run dart_scripthash_generator peercoin p92W3t7YkKfQEPDb7cG9jQ6iMh7cpKLvwK`  
returns  
`f83cf3b3ccddc19323fccef53417926f3303070abf4c6492164d2b0f513ad4e6`
### Networks supported
- Bitcoin (bitcoin, bitcoin_testnet)
- Peercoin (peercoin, peercoin_testnet)

PRs for other networks are welcome. Just add your network to `lib/networks.dart`.

### Prerequisites
- docker-compose

### Get started
1. Clone this repo.
2. run *./deploy.sh*
3. (optional) Create a *docker-compose.override.yml* file and modify the ports to your liking.  
4. You now have a microservice that will serve scripthashes. 