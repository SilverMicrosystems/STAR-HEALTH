public with sharing class AccountController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountsByType(String accountType) {
        return [SELECT Id, Name, Type, Industry, Phone FROM Account WHERE Type = :accountType];
    }
}