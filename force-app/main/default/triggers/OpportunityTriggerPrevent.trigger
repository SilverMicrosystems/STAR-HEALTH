trigger OpportunityTriggerPrevent on Opportunity(before Insert, before update, after Undelete){
    
    SET<Decimal> oppAmountSet = new SET<Decimal> ();
    
    if( (trigger.isBefore && (trigger.isInsert || trigger.isUpdate)) || (trigger.isAfter && trigger.isUndelete) ){
        for(Opportunity objOpp : trigger.new){
            if(objOpp.Amount != null)
                oppAmountSet.add(objOpp.Amount);
        }
    }
    
    Map<Decimal, Opportunity> oppMap = new Map<Decimal, Opportunity>();
    
    if(!oppAmountSet.isEmpty()){
        for(Opportunity objOpp : [Select Id, Amount from Opportunity where Amount IN : oppAmountSet]){
            oppMap.put(objOpp.Amount, objOpp);
        }
    }
    
    
    if(!oppMap.isEmpty()){
        if( (trigger.isBefore && (trigger.isInsert || trigger.isUpdate)) || (trigger.isAfter && trigger.isUndelete) ){
            for(Opportunity objOpp : trigger.new){
                if(oppMap.containsKey(objOpp.Amount)){
                    objOpp.addError('Opp with same amount already exists');
                }
            }
        }
    }
    
    
    
    
}