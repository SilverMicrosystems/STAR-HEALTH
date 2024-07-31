trigger AccountTriggerDuplicateNamePrevent on Account (before insert, before update, after undelete) {
    
    Set<String> accNameSet = new Set<String>();
    Set<String> accRatingSet = new Set<String>();
    
    if( (trigger.isBefore && (trigger.isInsert || trigger.isUpdate)) || (trigger.isAfter && trigger.isUndelete) ){
        for(Account objAcc : trigger.new){
            accNameSet.add(objAcc.Name); 
            accRatingSet.add(objAcc.Rating);
        }
        
        Map<String, Account> accExistingNameMap = new Map<String, Account>();
        Map<String, Account> accExistingRatingMap = new Map<String, Account>();
        if(!accNameSet.isEmpty()){
            for(Account objAcc : [Select Id, Name,Rating from Account where Name IN : accNameSet and Rating IN : accRatingSet]){
                accExistingNameMap.put(objAcc.Name, objAcc);
                accExistingRatingMap.put(objAcc.Rating, objAcc);
                
            }
        }
        
        if(!accExistingNameMap.isEmpty()){
            if( (trigger.isBefore && (trigger.isInsert || trigger.isUpdate)) || (trigger.isAfter && trigger.isUndelete) ){
                for(Account objAcc : trigger.new){
                    if(accExistingNameMap.containsKey(objAcc.Name) && accExistingRatingMap.containsKey(objAcc.Rating)){
                        objAcc.addError(objAcc.Name+' This account name is already exists with same rating');
                    }           
                }
            }
        }
    }
}