public class AccountTriggerTestFuture {

      @future
    public static void createProfileUser(Id objAccId){
        Profile p = [select id from profile where name='Policy Manager'];
        UserRole r = [Select id from userrole where name='CEO'];
        
        //SETUP OBJECT
        User u = new User(alias = 'standt', email='rani@silver.com', 
                          emailencodingkey='UTF-8', lastname='Testing', 
                          languagelocalekey='en_US', 
                          localesidkey='en_US', profileid = p.Id, userroleid = r.Id,
                          timezonesidkey='America/Los_Angeles', 
                          username='rani@silver.com');
        
        insert u;
        
        Account objAcc = [Select Id, Name, Rating from Account where ID =: objAccId];
        
        try{
            System.runAs(u){
                objAcc.Rating = 'Warm';
                update objAcc;
            } 
        }
        catch(Exception ex){
            Boolean errorMessageFlag = ex.getMessage().contains('Policy Manager users can not update the Account Record') ? true : false;
            System.assertEquals(true, errorMessageFlag);
        }
        
    }
}