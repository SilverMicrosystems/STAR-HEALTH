public with sharing class AccountProvider {
    
    @AuraEnabled(cacheable = true) // To call from LWC Using Wire Service
    public static List<Account> getAccountUsingWire(Id accId){
     
         return [Select Id, Name, Type from Account where Id = :accId ];
         
    
    }

    @AuraEnabled
    public static String createNewAccount(Account objAcc){
        if(Account.SObjectType.getDescribe().isAccessible() && Schema.SObjectType.Account.fields.Name.isAccessible()) {
            Account objAccountInsert = new Account(Name = objAcc.Name);
            insert objAccountInsert;
            
            return 'New Account ' +objAcc.Name+' has been craeted successfully';
       }
       
       else{
       
       return null;
       }
    }


    @AuraEnabled
    public static List<Account> searchAccountRecords(Account objAccount){
       return [Select Id, Name, Rating, Type, CreatedDate, SLA__c from Account where Type =: objAccount.Type];
    }

   @AuraEnabled
   public static List<Account> searchAccountDateRange(Account objAccount, Date fromDate, Date toDate){
    try {
        return [Select Id, Name, Rating, Type, CreatedDate, SLA__c from Account where Type =: objAccount.Type and CreatedDate>=:fromDate and CreatedDate <=: toDate];
    } catch (Exception e) {
        return null;
    }
   }

   @AuraEnabled
   public static List<Account> searchAccountByChar(Account objAccount){ // Type = Prospect , A
    try {
        return [Select Name, Type, CreatedDate, Rating from Account where Name like :  objAccount.Name+'%' and Type=:objAccount.Type ];
    } catch (Exception e) {
       return null;
    }
   }

   @AuraEnabled
   public static List<Account> searchAccounRecordTypeDateRange(Account objAcc, Date fromDate, Date toDate){
    try {
        System.debug('ACC Received = '+objAcc);
        System.debug('From Date '+fromDate + ', To Date '+toDate);
      return [select Id, Name, Rating, CreatedDate, SLA__c, Type from Account where Type =: objAcc.Type and CreatedDate>=: fromDate and CreatedDate <=: toDate];
      
    } catch (Exception e) {            
        return null;
        
    }
}

@AuraEnabled
public static List<Account> deleteSelectedAccountRecords(List<Id> accIdList, Account objAccount, Date fromDate, Date toDate){
    try {
        
        List<Account> accList = [Select Id from Account where Id IN : accIdList];
        Database.delete(accList ,false);

        return AccountProvider.searchAccounRecordTypeDateRange(objAccount , fromDate , toDate); //Code Re-Usability

    } catch (Exception e) {
        throw new AuraHandledException(e.getMessage());
    }
}
    

@AuraEnabled
public static List<Account> getLatest10AccountRecords(){
    try {
        return [Select Id, Name, Rating, Type,CreatedDate from Account ORDER BY CreatedDate desc LIMIT 10];
    } catch (Exception e) {
        throw new AuraHandledException(e.getMessage());
    }
}

@AuraEnabled
public static List<Contact> getRelatedContactRecords(Account objAccount){
    try {
        
        return [Select Id, FirstName, LastName from Contact where Account.Name =: objAccount.Name];


    } catch (Exception e) {
        throw new AuraHandledException(e.getMessage());
    }
}

}