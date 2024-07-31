global class BatchAccountRating implements Database.Batchable<sObject>{

     global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('Select Id, Rating from Account where Rating !=\'Hot\' ');
    }
    
    global void execute(Database.BatchableContext BC, List<Account> accList){
        if(!accList.isEmpty()){
            for(Account objAcc : accList){
                objAcc.Rating = 'Hot';
            }
            
            Database.update(accList, false);
        }
    }
    
    global void finish(Database.BatchableContext BC){
        
    }
    
}