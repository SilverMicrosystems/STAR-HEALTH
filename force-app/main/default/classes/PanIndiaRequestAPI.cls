global class PanIndiaRequestAPI {

   global static void getAccounts(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:PanIndiaNamedCreds/services/apexrest/getAccountDetails'); //Target Endpoint URL    
          
        request.setMethod('PUT');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');     
        request.setBody('[{"Name" : "PWC100",  "Rating" : "Cold", "SLA" : "Silver", "Type" : "Other"   },  { "Name" : "Deloitte100", "Rating" : "Warm", "SLA" : "Gold", "Type" : "Other"  } ]');
        
        HttpResponse response = http.send(request);
        System.debug('Response Status Code = '+response.getStatusCode()); //Status Code
        System.debug('Received Data = '+response.getBody()); //JSON Response Body
        
        if(response.getStatusCode() == 200){
                 System.debug('Received Data = '+response.getBody()); //JSON Response Body
        }
    }
    
    global class PanIndiaRequestAPIWrapper{
        global String Name;
        global String Type;
        global String SLA;
    }

    
}