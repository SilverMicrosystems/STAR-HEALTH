@isTest (seeallData = false)
public with sharing class AccountProviderTest {
    

    @isTest
    public static void testgetAccountUsingWire(){
     
        Account objAcc = new Account(Name='HDFC Bank', Type='Prospect');
        insert objAcc;
        
       List<Account> accountActualList =   AccountProvider.getAccountUsingWire(objAcc.Id);

       System.assertEquals(1, accountActualList.size());
    }


    @isTest
    public static void testcreateNewAccount(){
        Account objAcc = new Account(Name='HDFC Bank');
        
        AccountProvider.createNewAccount(objAcc);
    }
    






}