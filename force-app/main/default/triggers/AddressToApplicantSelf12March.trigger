trigger AddressToApplicantSelf12March on Address__c (before insert, before update) {
    
    Set<Id> appIDSet = new Set<Id>();
    if( (trigger.isInsert || trigger.isUpdate) && trigger.isBefore){
        for(Address__c objAdr : trigger.new){
            if(objAdr.Applicant__c !=null){
                if(trigger.isInsert){
                    appIDSet.add(objAdr.Applicant__c);
                }
                if(trigger.isUpdate){
                    if(objAdr.Applicant__c != trigger.oldMap.get(objAdr.Id).Applicant__c || objAdr.City__c != trigger.oldMap.get(objAdr.Id).City__c){ 
                        appIDSet.add(objAdr.Applicant__c);
                    }
                }
            }
        }
    }
    
    Map<ID,Applicant__c> appMap = new Map<ID,Applicant__c>();
    if(!appIDSet.isEmpty()){
        for(Applicant__c objAcc : [select Id,Police_Verification__c from Applicant__c where ID IN : appIDSet]){
            appMap.put(objAcc.Id, objAcc);
        }
    }
    
    if( (trigger.isInsert || trigger.isUpdate) && trigger.isBefore){
        for(Address__c objAdr : trigger.new){
            if(appMap.containsKey(objAdr.Applicant__c)){
                if(appMap.get(objAdr.Applicant__c).Police_Verification__c){ //It will also check for True
                    objAdr.City__c = 'Nagpur';
                    objAdr.State__c ='Maharashtra';
                    objAdr.Country__c = 'Bharat';
                }
                
            }
        }
    }
        
}