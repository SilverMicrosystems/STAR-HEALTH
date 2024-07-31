public class ContactTriggerSendNSDLHandlerAPI {

    @future(callout=true)
    public static void sendContactToNSDLTarget(Set<Id> conIdSet){
        List<Contact> conList = [select Id, FirstName, LastName from Contact where ID IN : conIdSet];
        
        if(!conList.isEmpty()){
            for(Contact objCon : conList){
                //Modify Target Username and Password with Security Token
                partnerSoapSforceCom.Soap myPartnerSoap =  new partnerSoapSforceCom.Soap();        
                partnerSoapSforceCom.LoginResult partnerLoginResult = myPartnerSoap.login('panindialimited@panindialimited.ax' , 'Pass#111eqf2Mqu7S5Hn8iQaZsAIFMEs');
                String sessionIdFetch = partnerLoginResult.sessionId;
                
                //Modify WDSL class Name of Target API Class
                soapSforceComSchemasClassContacttar.SessionHeader_element webserviceSessionHeader = new soapSforceComSchemasClassContacttar.SessionHeader_element();
                webserviceSessionHeader.sessionId = sessionIdFetch;
                
                //Modify WDSL class Name and Target API Class
                soapSforceComSchemasClassContacttar.ContactTargetAPISoap objTargetAPI = new soapSforceComSchemasClassContacttar.ContactTargetAPISoap();
                objTargetAPI.SessionHeader  = webserviceSessionHeader;
                
                //Modify Target Method Name
                String responseStr = objTargetAPI.createContact(objCon.FirstName, objCon.LastName);
                System.debug('#Receieved = '+responseStr);
                
                
                
            }
        }
        
    }
    
    
}