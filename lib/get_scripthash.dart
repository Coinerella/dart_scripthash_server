import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:coinslib/coinslib.dart';
import 'package:crypto/crypto.dart';
import 'package:dart_scripthash_generator_server/networks.dart' as networks;

Future<Response> getScripthashHandler(Request request) async {
  final network = request.params['network'];
  final address = request.params['address']!;
  final availableNetworks = networks.availableNetworks;

  if (!availableNetworks.containsKey(network)) {
    return Response.badRequest(body: 'Network $network not available');
  } else if (!Address.validateAddress(address, availableNetworks[network])) {
    return Response.badRequest(body: 'Address $address not valid for $network');
  } else {
    return Response.ok(getScriptHash(address, availableNetworks[network]!));
  }
}

String getScriptHash(String address, NetworkType network) {
  var script = Address.addressToOutputScript(address, network);
  var hash = sha256.convert(script).toString();
  return (reverseString(hash));
}

String reverseString(String input) {
  var items = [];
  for (var i = 0; i < input.length; i++) {
    items.add(input[i]);
  }
  var itemsReversed = [];
  items.asMap().forEach((index, value) {
    if (index % 2 == 0) {
      itemsReversed.insert(0, items[index + 1]);
      itemsReversed.insert(0, value);
    }
  });
  return itemsReversed.join();
}
