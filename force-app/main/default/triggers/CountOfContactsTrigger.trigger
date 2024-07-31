trigger CountOfContactsTrigger on Contact (before insert, before update, after undelete) {
    
    SET<ID> accIdSet = new SET<ID>();
    if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate) || (trigger.isAfter && trigger.isUndelete)){
        for(Contact objCon : trigger.new){
            if(objCon.AccountId !=null){
                
                if(trigger.isInsert || trigger.isUndelete){
                    accIdSet.add( objCon.AccountId);
                }
                if(trigger.isUpdate){
                    if(objCon.AccountId != trigger.oldMap.get(objCon.Id).AccountId){
                        accIdSet.add(objCon.AccountId);
                    }
                }
                
            }
            
        } 
    }
    
    Map<Id,Account> accMap = new Map<Id, Account>();
    if(!accIdSet.isEmpty()){
        for(Account objAcc : [Select Id,Name, (Select Id, Email from Contacts) from Account where ID IN : accIdSet]){ 
            accMap.put(objAcc.Id, objAcc);
        }
    }
    
    if(!accMap.isEmpty()){
        if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate) || (trigger.isAfter && trigger.isUndelete)){
            for(Contact objCon : trigger.new){ //c2@Gmail.com
                if(accMap.containsKey(objCon.AccountId)){
                    List<Contact>  conExistingList = accMap.get(objCon.AccountId).Contacts; // returns a list of existing contact
                        
                        for(Contact objExtObj : conExistingList){
                            if(objCon.Email == objExtObj.Email){
                                objCon.Email.addError(objCon.Email+' This Email id Contacts is already exists on '+accMap.get(objCon.AccountId).Name);
                            }
                        }
                } 
            }
        }
        
        
        
        
    }
}