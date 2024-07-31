global class BatchAccount implements Database.Batchable<sObject>{
    
    global Database.queryLocator start(Database.BatchableContext BC){
        System.debug('#START METHOD');
        return Database.getQueryLocator('Select Type, Rating from Account where Type = \'Prospect\' and Rating!=\'Cold\' '); //Query
    }
    
    global void execute(Database.BatchableContext BC, List<Account> accList){
         System.debug('#EXECUTE METHOD');
        if(!accList.isEmpty()){ 
            for(Account objAcc : accList){
                objAcc.Rating = 'Cold';
            }
        }
        
        Database.update(accList, false);
        
    }
    
    global void finish(Database.BatchableContext BC){
         System.debug('#FINISH METHOD');
    }
}