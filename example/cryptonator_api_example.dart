import 'package:cryptonator_api/cryptonator_api.dart';
import 'package:http/http.dart';

main() async {
  final api = new Cryptonator(new Client());
  /// Fetch BTC price information
  print(await api.fullBTC);
}
