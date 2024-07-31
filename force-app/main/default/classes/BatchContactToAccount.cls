global class BatchContactToAccount implements Database.Batchable<sObject>{
    
    global Database.queryLocator start(Database.BatchableContext BC){       
        return Database.getQueryLocator('Select Id, FirstName, LastName, LeadSource, Account.Name, Account.Rating,AccountId from Contact where LeadSource=\'Web\' and Account.Rating !=\'Cold\' and AccountId!=null');
    }
    
    global void execute(Database.BatchableContext BC, List<Contact> conList){
        Set<Id> accIdSet = new Set<Id>();
        if(!conList.isEmpty()){
            for(Contact objCon : conList){
                accIdSet.add(objCon.AccountId);
            }
        }
        
        Map<Id,Account> accMap = new Map<ID,Account>();
        for(Account objAcc : [Select Id, Rating from Account where Id IN : accIdSet]){
            accMap.put(objAcc.Id, objAcc);
        }
        
        if(!accMap.isEmpty()){
            for(Contact objCon : conList){
                if(accMap.containsKey(objCon.AccountId)){
                    accMap.get(objCon.AccountId).Rating = 'Cold';
                }
            }
            
            Database.update(accMap.values(), false);
        }
        
       
        
    }
    
    global void finish(Database.BatchableContext BC){
        
    }
}