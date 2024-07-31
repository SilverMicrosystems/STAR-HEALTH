public inherited sharing class DataProvider {


    public static List<Account> getAllRecords () {
        try {
            return [Select Id, Name, SLA__c from Account ]; 
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}