import 'package:cryptonator_api/cryptonator_api.dart';
import 'package:test/test.dart';
import 'package:http/http.dart';

void main() {
  group('A group of tests', () {
    setUp(() {
    });

    test('First Test', () async {
      final api = new Cryptonator(new Client());
      final PriceFull btc = await api.fullBTC;
      expect(btc.base, 'BTC');
      expect(btc.target, 'USD');
      expect(btc.price, new isInstanceOf<double>());
      expect(btc.volume, new isInstanceOf<double>());
      expect(btc.change, new isInstanceOf<double>());
    });
  });
}
