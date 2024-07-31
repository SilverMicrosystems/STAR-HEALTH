public class veriphoneIntegration {
    
    @AuraEnabled
    public static Boolean sendVeriphoneIntegration(Contact objCon){
        
        Contact objContact = [SELECT MobilePhone FROM Contact WHERE FirstName=:objCon.FirstName and LastName=: objCon.LastName LIMIT 1];
        String MobilePhone = objContact.MobilePhone;

        System.debug('Record ID=' + objContact.Id + ' MobilePhone=' + MobilePhone);
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        
        request.setEndpoint('https://api.veriphone.io/v2/verify?phone=' + MobilePhone + '&key=6CCC34A96CF44B209B5766ACDA0A2938');
        request.setMethod('GET');
        System.debug('#request=' + request.getBody());
        
        HttpResponse response = http.send(request);
        System.debug('#Response = ' + response.getBody());
        
        Boolean mystatus = false;
        
        if(response.getStatusCode() == 200){
            SourceAccountRequestAPIWrapper objWrapInstance = (SourceAccountRequestAPIWrapper) JSON.deserialize(response.getBody(), SourceAccountRequestAPIWrapper.class);
            
            System.debug('Status ' + objWrapInstance.status);
            System.debug('Valid? ' + objWrapInstance.phone_valid);
            
            mystatus = objWrapInstance.phone_valid;
            
            Contact objConNew = new Contact(Id = objContact.Id);
            objConNew.Mobile_Verified__c = objWrapInstance.phone_valid;
            
            if(objWrapInstance.phone_valid){
                objConNew.Mobile_Active__c = true;
                objConNew.Mobile_Service_Operator__c = objWrapInstance.carrier;
            } else {
                objConNew.Mobile_Active__c = false;
                objConNew.Mobile_Service_Operator__c = '';
            }
            update objConNew;
        }
        return mystatus;
    }
}