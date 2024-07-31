@isTest(seeAllData = false)
public class BatchApplicantPoliceVerTest {
    
    
    public static testMethod void testBatchMethod(){
        
        List<Applicant__c> appListInsert = new List<Applicant__c>(); 
        for(Integer i=1; i<=200; i++){
            Applicant__c objApp = new Applicant__c(First_Name__c='Bunty'+i , Last_Name__c='Modi'+i, Pan_Card__c='AVTPP9090R', Gender__c='Male');
            appListInsert.add(objApp);            
        }
        if(!appListInsert.isEmpty()){
            Database.Insert(appListInsert, false);
        }
        
        Test.startTest();
        	Database.executeBatch(new BatchApplicantPoliceVer(), 200); //Code Coverage
        Test.stopTest(); 
        
        //Tally Business Logic
        
        System.assertEquals(200 , [Select Id from Applicant__c where Police_Verification__c = true].size()); 
        
        
    }
}