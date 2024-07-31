trigger ApplicantTriggerEmailPoliceVer on Applicant__c (after update) {
    
    List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();
    
    if(trigger.isAfter && trigger.isUpdate){
        for(Applicant__c objAcc : trigger.new){
            
            if(objAcc.Police_Verification__c != trigger.oldMap.get(objAcc.Id).Police_Verification__c){
                    if(objAcc.Police_Verification__c && String.isNotBlank(objAcc.Email_Id__c)){
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        mail.setToAddresses(new String[] {objAcc.Email_Id__c});
                        mail.setSenderDisplayName('Silver Micro');
                        mail.setSubject('Police Verification Mail');
                        mail.setPlainTextBody('Hi '+objAcc.First_Name__c+'\n Your are eligible for Police Verification.Kindly visit to your nearest Police Station.  Pyar Se Karenge Apka Swagat. \n Team Zingalala');
                        mailList.add(mail);
                        
                    }
        }
        }
        
            if(!mailList.isEmpty())
             Messaging.sendEmail(mailList);

    }
}