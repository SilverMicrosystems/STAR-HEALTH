global class BatchApplicantNewYear implements Database.Batchable<sObject>{
    
    global Database.queryLocator start(Database.BatchableContext BC){
        
        return Database.getQueryLocator('select Id, First_Name__c, Email_Id__c from Applicant__c where Email_Id__c !=null ');
    }
    
    global void execute(Database.BatchableContext BC, List<Applicant__c> appList){
        List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();
        
        if(!appList.isEmpty()){
            for(Applicant__c objApp : appList){
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(new String[] {objApp.Email_Id__c});
                mail.setSenderDisplayName('Silver Micro');
                mail.setSubject('Happy New Year');
                                mail.setPlainTextBody('Hello '+objApp.First_Name__c+'\n'+'Happy New Year To you.');
                                mailList.add(mail);   
                                }
                         }
                                
                                if(!mailList.isEmpty()){
                                    Messaging.sendEmail(mailList,false);  
                                }
                                
                                }
                                
                                
                                
                                
                                
                                global void finish(Database.BatchableContext BC){
                                    
                                }
                                
                                
                                }