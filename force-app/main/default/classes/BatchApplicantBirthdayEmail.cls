global class BatchApplicantBirthdayEmail implements Database.Batchable<sObject> {
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator ('Select Id,Name,  First_Name__c, Last_Name__c, Email_Id__c, DOB__c from Applicant__c where Email_Id__c !=null and DOB__c !=null ');
    }
    
    global void execute(Database.BatchableContext BC, List<Applicant__c> appList){               
       
        List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();
        
        if(!appList.isEmpty()){
            for(Applicant__c objApp : appList){
                
                Integer birthDay =  objApp.DOB__c.day(); //26   26 March 1980
                Integer todayDay =   system.today().day(); //26  26 March 2024
               
                Integer birthMonth =     objApp.DOB__c.month(); //03  26 March 1980
				Integer todayMonth =   system.today().month(); //03  26 March 2024

                
                if(birthDay == todayDay && birthMonth== todayMonth){
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    mail.setToAddresses(new String[] {objApp.Email_Id__c});
                    mail.setSenderDisplayName('Silver Micro');
                    mail.setSubject('Happy Birthday');
                    mail.setPlainTextBody('Hi '+objApp.First_Name__c+', \n Happy Birthday to you. \n Team \n Zingalala Pvt Ltd.');
                    mailList.add(mail);
                    
                    
                }
                
                
            }
            
            if(!mailList.isEmpty())
            		Messaging.sendEmail(mailList);
        } 
    }
    
    global void finish(Database.BatchableContext BC){
        
        
    }
    
}