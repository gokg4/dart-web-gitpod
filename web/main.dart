import 'dart:html';

import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

import 'package:intl/intl.dart';

void main () async {
    final header = querySelector('#header');
    header?.text = "Hello, World!";
    final date = querySelector('#date');
    final inr = querySelector('#inr');
    inr?.text = "Rs.000";
    final usd = querySelector('#usd');
    usd?.text = "USD.000";
    final eur = querySelector('#eur');
    eur?.text = "Eur.000";
    final gbp = querySelector('#gbp');
    gbp?.text = "GBP.000";
    final title = querySelector('#title');
    title?.text = "";
    final link = querySelector('#footer') as AnchorElement;
    link.href = 'https://www.coingecko.com/en/api';
    link.text = 'Powered By: CoinGecko API';
    link.target = '_blank';
    // final date = querySelector('#date');
    // date?.text = DateFormat.yMMMd().add_jm().format(DateTime.now());
    String? crypto = "ethereum";
    var queryParameters = {
        'vs_currencies': 'inr,usd,eur,gbp',
        'ids': crypto
    };
    var now = DateFormat.yMMMd().add_jm().format(DateTime.now());
    var formatterinr = NumberFormat.currency(locale: "en_IN", symbol: "₹", decimalDigits: 2);
    var formatterusd = NumberFormat.currency(locale: "en_US", symbol: "\$", decimalDigits: 2);
    var formattereur = NumberFormat.currency(locale: "en_US", symbol: "€", decimalDigits: 2);
    var formattergbp = NumberFormat.currency(locale: "en_US", symbol: "£", decimalDigits: 2);
    var url = Uri.https('api.coingecko.com', '/api/v3/simple/price', queryParameters);
    var response = await http.get(url);
    
    if (response.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(response.body);
        final inr1 = jsonResponse[crypto]?['inr'];
        final usd1 = jsonResponse[crypto]?['usd'];
        final eur1 = jsonResponse[crypto]?['eur'];
        final gbp1 = jsonResponse[crypto]?['gbp'];
        header?.text = "${crypto.replaceFirst(crypto[0], crypto[0].toUpperCase())} Price Today";
        date?.text = "($now)";
        inr?.text = formatterinr.format(inr1);
        usd?.text = formatterusd.format(usd1);
        eur?.text = formattereur.format(eur1);
        gbp?.text = formattergbp.format(gbp1);
        title?.text = "${crypto.toUpperCase()} PRICE TODAY";
        print('Ethereum Price Today($now) in INR: $inr1, USD: $usd1, EUR: $eur1, GBP: $gbp1');        
    }   else {
        print('response.statusCode');
    }
}
