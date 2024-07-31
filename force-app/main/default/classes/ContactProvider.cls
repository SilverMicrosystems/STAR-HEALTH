public with sharing class ContactProvider {
    

    @AuraEnabled
    public static List<Contact> searchContactRecords(Account objAcc){
        try {
            
            return [Select Id, Name, Level__c from Contact where Account.Name =: objAcc.Name];

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}