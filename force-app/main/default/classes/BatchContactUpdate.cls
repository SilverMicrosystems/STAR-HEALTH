global class BatchContactUpdate implements Database.Batchable<sObject> {
    
    Set<String> successNameSet = new Set<String>();
    Set<String> failedNameSet = new Set<String>();    
    
    global Database.QueryLocator start(Database.BatchableContext BC){        
        return Database.getQueryLocator ('Select Id, LeadSource,Name, Level__c from Contact where LeadSource != \'Web\' ');//5
    }
    
    global void execute(Database.BatchableContext BC, List<Contact> conList){
        if(!conList.isEmpty()){
            for(Contact objCon : conList){
                objCon.LeadSource = 'Web';
            }            
            
            Database.SaveResult[] result =    Database.update(conList, false);// Total Records = 5, Success = 2, Failed = 03
            
            Integer index = 0;
            
            for(Database.SaveResult sr   :   result){
                if(sr.isSuccess()){
                    successNameSet.add(conList[index].Name);
                    index++;
                }
                else{
                    failedNameSet.add(conList[index].Name);
                    index++;
                }
            }
            
        }
        
        System.debug('# Success Set '+successNameSet);
        System.debug('# Failed Set '+failedNameSet);
        
    }
    
    global void finish(Database.BatchableContext BC){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] {'silvermicrosfdc@gmail.com'});
        mail.setSenderDisplayName('Silver Micro');
        mail.setSubject('Contact Updation List');
        mail.setPlainTextBody('Success '+successNameSet+'\n Failed= '+failedNameSet);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        
    }
    
}