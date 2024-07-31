trigger ContactTriggerEmail on Contact (after Delete) {
    
    List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();
    
    for(Contact objCon : trigger.old){
        if(String.isNotBlank(objCon.Email)){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] {objCon.Email});
        mail.setCcAddresses(new String[] {'silvermicrosfdc@gmail.com' , 'silvermicrosfdc@gmail.com' , 'silvermicrosfdc@gmail.com'});
        mail.setSenderDisplayName('Silver Micro');
        mail.setSubject('Record Deleted');
        mail.setPlainTextBody('Hi '+objCon.FirstName+'\n Your record has been deleted. \n Team Zingalala');
        mailList.add(mail);
        }
    }
    
    if(!mailList.isEmpty())
        Messaging.sendEmail(mailList);
}