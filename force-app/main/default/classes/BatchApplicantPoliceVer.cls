global class BatchApplicantPoliceVer implements Database.Batchable<sObject>{

    global Database.QueryLocator start(Database.BatchableContext BC){
           return Database.getQueryLocator('select Id, Police_Verification__c, Gender__c from Applicant__c where Gender__c=\'Male\' and Police_Verification__c=false');
    }
    
    global void execute(Database.BatchableContext BC, List<Applicant__c> applicantList){
        if(!applicantList.isEmpty()){
            for(Applicant__c objApp : applicantList){
                objApp.Police_Verification__c = true;
            }
            
            Database.update(applicantList,false);
        }
    }
    global void finish(Database.BatchableContext BC){
        
    }
}