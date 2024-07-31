trigger ContactToAccountSelfTrigger on Contact (before insert, before update , after Undelete) {

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
        for(Account objAcc : [Select Id, (Select Id from Contacts) from Account where ID IN : accIdSet]){ //ICICI Bank--> First Raju
            accMap.put(objAcc.Id, objAcc);
        }
    }
    
    if(!accMap.isEmpty()){
        if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate) || (trigger.isAfter && trigger.isUndelete)){
            for(Contact objCon : trigger.new){//Dusra Modi --> icici
                if(accMap.containsKey(objCon.AccountId)){
                  List<Contact> existingConList =   accMap.get(objCon.AccountId).Contacts ; // returns a list of existing contacts
                    
                    if(existingConList.size() >= 1){
                        objCon.addError('More than 01 Contacts are NOT allowed');
                    }
                }
            } 
        }
    }

}