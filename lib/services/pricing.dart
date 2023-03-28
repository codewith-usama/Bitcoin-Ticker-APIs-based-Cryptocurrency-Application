import 'networking.dart';

const bitCoinURL = 'https://exchange-rates.abstractapi.com/v1/live/';
const apiKey = '053bb5d42d6c4a50853f9ad04e9bd5b2';
class Price {

  Future<dynamic> getBTCCurrentPrice(String base, String currencyChanger) async{
    NetworkHelper networkHelper = NetworkHelper(url: '$bitCoinURL?api_key=$apiKey&base=$base&target=$currencyChanger', currencyChanger: currencyChanger);
    return await networkHelper.getData();
  }
}