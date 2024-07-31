global class BatchApplicantPolVer implements Database.Batchable<sObject>{

    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('select Id, Police_Verification__c, Gender__c from Applicant__c where Gender__c=\'Male\' and Police_Verification__c =false');
    }
    
    global void execute(Database.BatchableContext BC, List<Applicant__c> appList){
        if(!appList.isEmpty()){
            for(Applicant__c objApp : appList){
                objApp.Police_Verification__c = true;
            }
            
            Database.update(appList, false);
        }
    }
    
    global void finish(Database.BatchableContext BC){
        Database.executeBatch(new BatchAccountRating(), 100);
    }
    
    
}