trigger ContactToAccountTrigger on Contact (after insert) {

    Set<Id> accIdSet = new Set<Id>(); 
    if(trigger.isInsert && trigger.isAfter){
        for(Contact objCon : trigger.new){
            if(objCon.AccountId != null)
                    accIdSet.add(objCon.AccountId);
        }
    }
    
    Map<Id, Account> accMap = new Map<Id,Account>();
    if(!accIdSet.isEmpty()){
    for(Account objAcc : [Select Id, Description from Account where ID IN :  accIdSet]){
        accMap.put(objAcc.Id, objAcc);
    }
    }
    
    if(!accMap.isEmpty()){
     if(trigger.isInsert && trigger.isAfter){
        for(Contact objCon : trigger.new){
            if(accMap.containsKey(objCon.AccountId)){
                //Business Logic
               accMap.get(objCon.AccountId).Description   = objCon.FirstName+' '+objCon.LastName;
            }
        }
     }         
         Database.update(accMap.values(), false);
    }
}