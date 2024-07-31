@isTest
public with sharing class CarTest {
    

    @isTest
    public static void testFullName(){
      String returnedFullName =   Car.fullName('Mr' , 'Amit' , 'Prakash'); //Code Coverage
      System.assertEquals('Mr.Amit Prakash', returnedFullName);

    }
}