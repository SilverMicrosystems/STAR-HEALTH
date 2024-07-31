@isTest(seeAllData = FALSE)
public class AccountTriggerTest {
    
    @isTest
    public static void testInsertIndustryTechnology(){
        List<Account> accList = new List<Account>();
        for(Integer i=1; i<=200; i++){
            Account objAcc = new Account(Name='Bunty'+i, Industry='Technology', SLA__c='Silver');
            accList.add(objAcc);
        }
        
        if(!accList.isEmpty()){
            Database.insert(accList, false);
        }
        
        
        List<Account> actualAccountList =   [Select Id, Rating, Type, CustomerPriority__c from Account where CustomerPriority__c='High' ];
       System.assertEquals(207, actualAccountList.size()); 

    }
    
    
    
    
        public static testMethod void testAccountIndustryOtherThanTech(){
        
        List<Account> accList = new List<Account>();
        for(Integer i=1; i<=200; i++){
            Account objAcc = new Account(Name='Bunty'+i, Industry='Education', SLA__c='Silver');
            accList.add(objAcc);
        }
        
        if(!accList.isEmpty()){
            Database.insert(accList, false);
        }
        
       List<Account> actualAccountList =   [Select Id, Rating, Type, CustomerPriority__c from Account where CustomerPriority__c=null ];
       System.assertEquals(200, actualAccountList.size()); 
        
        
            
      //UPDATE OPERATION 
        
        for(Account objAcc : accList){
            objAcc.SLA__c = 'Bronze';
        }
        
        Database.update(accList, false);
        
        List<Account> actualAccountUpdatedList =   [Select Id, Rating, Type, CustomerPriority__c from Account where Active__c='Yes' ];
       System.assertEquals(200, actualAccountUpdatedList.size()); 
        
        
        
        
        //UPDATE OPERATION 
        
        for(Account objAcc : accList){
            objAcc.SLA__c = 'Gold'; // What was the SLA Old value = Bronze
        }
        
        Database.update(accList, false);
        
        List<Account> actualAccountUpdatedActiveNullList =   [Select Id, Rating, Type, CustomerPriority__c from Account where Active__c=null ];
       System.assertEquals(200, actualAccountUpdatedActiveNullList.size()); 
        
        
        //UPDATE OPERATION 
        
        try{
                    for(Account objAcc : accList){
                        objAcc.SLA__c = 'Platinum'; //New
                    }
                    
                    Database.update(accList, false);
        }
        catch(Exception ex){
            Boolean actualExceptionThrown =  ex.getMessage().contains('You can not set SLA to Platinum') ? true : false;            
            System.AssertEquals(true,actualExceptionThrown );            

        }
        
    }       
       
}