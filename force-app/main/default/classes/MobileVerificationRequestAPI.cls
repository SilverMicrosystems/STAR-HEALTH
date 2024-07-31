public class MobileVerificationRequestAPI {

    @future(callout=true)
    public static void verifiyMobileNumber(Set<Id> contactIdSet){//10
        
        List<Contact> conListUpdate = new List<Contact>();
        
        for(Contact objCon : [Select Id, MobilePhone from Contact where Id IN : contactIdSet]){
                String mobileNumber = objCon.MobilePhone;
        
                Http http = new Http();
                HttpRequest request = new HttpRequest();
                request.setEndpoint('https://api.veriphone.io/v2/verify?phone='+mobileNumber+'&key=B53AB4C3179E4B4D83770588E8FDAC65');
                request.setMethod('GET');
                
                HttpResponse response = http.send(request); // Target Hit 
                
                System.debug('Response Code '+response.getStatusCode());
                System.debug('Response Body '+response.getBody()); // return a JSON Serial
                
                Boolean mystatus;
        
        
                if(response.getStatusCode() == 200){
                      MobileVerificationRequestAPIWrapper objWrap = new MobileVerificationRequestAPIWrapper();
                     MobileVerificationRequestAPIWrapper objWrapInstance =   objWrap.parse(response.getBody());
                    
                    System.debug('Status '+objWrapInstance.status);
                    System.debug('Valid? '+objWrapInstance.phone_valid);
        
                    mystatus = objWrapInstance.phone_valid;
        
                    objCon.Mobile_Verified__c = true;
        
                    if(objWrapInstance.phone_valid == true){
                        objCon.Mobile_Active__c = true;
                        objCon.Mobile_Service_Operator__c = objWrapInstance.carrier;
                    }
                    else{
                        objCon.Mobile_Active__c = false;
                        objCon.Mobile_Service_Operator__c = '';
                    }
        
                    conListUpdate.add(objCon);
                }
        
                }
        
        if(!conListUpdate.isEmpty())
        		Database.update(conListUpdate, false);
        
    }
    
    
   public class MobileVerificationRequestAPIWrapper {

	public String status;
	public String phone;
	public Boolean phone_valid;
	public String phone_type;
	public String phone_region;
	public String country;
	public String country_code;
	public String country_prefix;
	public String international_number;
	public String local_number;
	public String e164;
	public String carrier;

	
	public MobileVerificationRequestAPIWrapper parse(String json) {
		return (MobileVerificationRequestAPIWrapper) System.JSON.deserialize(json, MobileVerificationRequestAPIWrapper.class);
	}
}
}