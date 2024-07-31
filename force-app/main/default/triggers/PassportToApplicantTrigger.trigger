trigger PassportToApplicantTrigger on Passport__c (after insert, after update) {
    
    Set<Id> applicantIdSet = new Set<Id>();        
    if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate)){
        for(Passport__c objPass : trigger.new){
            if(objPass.Applicant__c != null){
               
                IF(trigger.isInsert){
                    applicantIdSet.add(objPass.Applicant__c); //Parent Id 
                }
                
                if(trigger.isUpdate){
                    if(objPass.Status__c != trigger.oldMap.get(objPass.Id).Status__c){
                         applicantIdSet.add(objPass.Applicant__c); //Parent Id 
                    }
                }
            
            }
        }
    }
    
    Map<Id,Applicant__c> appMap = new Map<Id,Applicant__c>();
    if(!applicantIdSet.isEmpty()){
        for(Applicant__c objApp : [Select Police_Verification__c from Applicant__c where ID IN : applicantIdSet]){
            appMap.put(objApp.Id, objApp);        
        }
    }
    
    if(!appMap.isEmpty()){    
        if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate)){
            for(Passport__c objPass : trigger.new){
                if(appMap.containsKey(objPass.Applicant__c)){
                    if(objPass.Status__c == 'Rejected'){
                        appMap.get(objPass.Applicant__c).Police_Verification__c = true;
                    }
                    else{
                        appMap.get(objPass.Applicant__c).Police_Verification__c = false;
                    }
                }
            }
            
            Database.update(appMap.values(), false);
        }
    }
    
}