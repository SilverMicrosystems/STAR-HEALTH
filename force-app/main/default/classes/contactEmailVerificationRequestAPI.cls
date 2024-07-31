public with sharing class contactEmailVerificationRequestAPI {
   @AuraEnabled 

   public static String sendEmailIntegrationContact(Contact objCon){

      String Email = objCon.Email;
    
       
  Http http = new Http();
  HttpRequest request = new HttpRequest();
  request.setEndpoint('https://emailvalidation.abstractapi.com/v1/?api_key=10fb4efd85a641af8caef866bf923b7c&email='+Email);
  request.setMethod('GET');
  
  HttpResponse response = http.send(request); 
  
  System.debug('Response Code '+response.getStatusCode());
  System.debug('Response Body '+response.getBody()); 
  
    String deliverability;
  if(response.getStatusCode() == 200){
      SourceLeadRequestAPIWrapper objWrap = new SourceLeadRequestAPIWrapper();
    SourceLeadRequestAPIWrapper objWrapInstance =   objWrap.parse(response.getBody());
      
     System.debug('Email'+objWrapInstance.email);
     System.debug('Deliverability ? '+objWrapInstance.deliverability);
      
      
      if(objWrapInstance.deliverability=='DELIVERABLE'){
          deliverability = objWrapInstance.deliverability;
          
          Contact objConNew = new Contact(FirstName=objCon.FirstName, LastName = objCon.LastName, Email = objCon.Email );
          Insert objConNew;
      }
    
  }
   return deliverability;
}

}