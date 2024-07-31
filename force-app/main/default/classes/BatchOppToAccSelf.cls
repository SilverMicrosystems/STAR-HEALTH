global class BatchOppToAccSelf implements Database.Batchable<sObject>{
    
    global Database.queryLocator start(Database.BatchableContext BC){       
        return Database.getQueryLocator('Select Id, StageName, Description,Amount,Account.Name, Account.SIC from Opportunity where StageName!=\'Closed Won\' and Amount > 5000 and Accountid!=null');
    }
    
    global void execute(Database.BatchableContext BC, List<Opportunity> oppList){
     
        if(!oppList.isEmpty()){
            for(Opportunity objOpp : oppList){
                objOpp.StageName = 'Closed Won';
                objOpp.Description = objOpp.Account.SIC;//Child's Parenty Field
            }
            
            Database.update(oppList, false);
        }
       
        
    }
    
    global void finish(Database.BatchableContext BC){
               //Send Acknowledgement Email
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] {'silvermicrosfdc@gmail.com'});
        mail.setSenderDisplayName('Silver Micro');
        mail.setSubject('Batch Class Status');
        mail.setPlainTextBody('Batch Class Finished');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

    }
}