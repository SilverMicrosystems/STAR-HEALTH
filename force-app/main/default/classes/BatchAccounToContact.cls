global class BatchAccounToContact implements Database.Batchable<sObject> {
    
    global Database.queryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('Select Id, Type, Phone from Account where Type =\'Prospect\' ');
    }
    
    global void execute(Database.BatchableContext BC, List<Account> accList){
        
        //Parent to Child Steps
       
        Map<Id, Account> accMap = new Map<Id,Account>();
        
        if(!accList.isEmpty()){
            for(Account objAcc : accList){
                accMap.put(objAcc.Id, objAcc);
            }
        }
        
        List<Contact> conList = new List<Contact>();
        for(Contact objCon : [Select Id, Level__c, AccountId from Contact where AccountId IN : accMap.keySet() and  Level__c != 'Primary']){
            conList.add(objCon);
        }
        
        if(!conList.isEmpty()){
            for(Contact objCon : conList){
                if(accMap.containsKey(objCon.AccountID)){
                    objCon.Level__c = 'Primary';
                    objCon.MobilePhone = accMap.get(objCon.AccountID).Phone;
                }
            }
            
            Database.update(conList, false);
        }
        
    }
    
    global void finish(Database.BatchableContext BC){
        
    }
}