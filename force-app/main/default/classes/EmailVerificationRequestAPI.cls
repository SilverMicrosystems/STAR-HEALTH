public with sharing class EmailVerificationRequestAPI {
  @AuraEnabled 
  public static String sendEmailIntegration(Lead objLead){

        String Email = objLead.Email;
      
      	
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
            
            Lead objLeadNew = new Lead(FirstName=objLead.FirstName, LastName = objLead.LastName, Email = objLead.Email , Company = objLead.Company, Status = objLead.Status );
            Insert objLeadNew;
        }
      
    }
     return deliverability;
}

  }