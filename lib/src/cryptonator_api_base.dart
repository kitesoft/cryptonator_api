library cryptonator.api;

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';

/// Interface to access Cryptonator API
class Cryptonator {
  /// HTTP client instance used to place REST calls to Cryptonator server
  final BaseClient client;

  /// Creates a new instance of [Crytonator] with given [client]
  Cryptonator(this.client);

  /// Get full price for the given coin [coin]
  Future<PriceFull> getFull(String coin) async {
    final resp =
    await client.get('https://api.cryptonator.com/api/full/$coin-usd');
    return new PriceFull.fromMap(JSON.decode(resp.body));
  }

  /// Get full price for BTC
  Future<PriceFull> get fullBTC => getFull('btc');

  /// Get full price for LTC
  Future<PriceFull> get fullLTC => getFull('ltc');

  /// Get full price for ETH
  Future<PriceFull> get fullETH => getFull('eth');

  /// Get full price for WTC
  Future<PriceFull> get fullWTC => getFull('wtc');

  /// Get full price for ADX
  Future<PriceFull> get fullADX => getFull('ADX');

  /// Get full price for NEO
  Future<PriceFull> get fullNEO => getFull('NEO');

  /// Get full price for GAS
  Future<PriceFull> get fullGAS => getFull('GAS');

  /// Get full price for NAV
  Future<PriceFull> get fullNAV => getFull('NAV');
}

/// Model class to hold full price information
class PriceFull {
  /// Time at which the price information was collected
  final DateTime time;

  /// Base currency
  final String base;

  /// Target currency
  final String target;

  /// Price
  final double price;

  /// Volume
  final double volume;

  /// Change
  final double change;

  /// Markets
  final Map<String, Market> markets;

  const PriceFull(
      {this.time,
        this.base,
        this.target,
        this.price,
        this.volume,
        this.change,
        this.markets});

  factory PriceFull.fromMap(Map map) {
    final Map tickerMap = map['ticker'];
    final double price = double.parse(tickerMap['price'], (_) => 0.0);
    final double volume = double.parse(tickerMap['volume'], (_) => 0.0);
    final double change = double.parse(tickerMap['change'], (_) => 0.0);

    final markets = <String, Market>{};
    for (Map marketMap in tickerMap['markets']) {
      final market = new Market.fromMap(marketMap);
      markets[market.name] = market;
    }

    // TODO parse time
    return new PriceFull(
        base: tickerMap['base'],
        target: tickerMap['target'],
        price: price,
        volume: volume,
        change: change,
        markets: markets);
  }

  String toString() {
    final sb = new StringBuffer();
    sb.writeln('$base to $target');
    sb.writeln('Price: $price');
    sb.writeln('Volume: $volume');
    sb.writeln('Change: $change');
    sb.writeln('Markets: ');
    for (Market market in markets.values) {
      sb.writeln('  $market');
    }
    return sb.toString();
  }
}

/// Model class for a market
class Market {
  /// Name of the market
  final String name;

  /// Price of the coin in the market
  final double price;

  /// Volume of the coin in the market
  final double volume;

  const Market(this.name, this.price, this.volume);

  factory Market.fromMap(Map map) {
    final double price = double.parse(map['price'], (_) => 0.0);
    return new Market(map['market'], price, map['volume'].toDouble() ?? 0.0);
  }

  String toString() {
    final sb = new StringBuffer();
    sb.write('$name [Price: $price] [Volume: $volume]');
    return sb.toString();
  }
}
