public class INRToUSDConvertApi {
 @AuraEnabled
    public static double getConvertedAmount(String currencyFrom, String currencyTo, Decimal amount) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String endpoint = 'https://anyapi.io/api/v1/exchange/convert?base=' + currencyFrom + '&to=' + currencyTo + '&amount=' + amount + '&apiKey=u5ncikeusf86he1qgcfabgjvokpdc7uhgdmhfv30vus8m7b5d1ob748';
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        
        HttpResponse response = http.send(request); 
        
        System.debug('Response Code ' + response.getStatusCode());
        System.debug('Response Body ' + response.getBody());     
        double convertedAmount = 0;
        if(response.getStatusCode() == 200) {
            INRToUSDRequestAPIWrapper objWrap = (INRToUSDRequestAPIWrapper) System.JSON.deserialize(response.getBody(), INRToUSDRequestAPIWrapper.class);
            System.debug('Converted Amount: ' + objWrap.converted);
            convertedAmount = objWrap.converted;
        }
        return convertedAmount;
    }
}