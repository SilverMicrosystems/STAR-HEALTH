@isTest
public class CalculationTest {

    @isTest
    public static void additionTest(){
       Integer actualAddition =  Calculation.addition(10, 20); //Code Coverage
       System.assertEquals(30 , actualAddition); //Expected Value, Actual Value //To Tally the Business Logic
    }
    

    public static testMethod void fullNameTest(){
        Calculation objCal = new Calculation();
        String actualFullName = objCal.fullName('Bunty' , 'Modi'); //Code Coverage
        System.assertEquals('Bunty Modi' , actualFullName); //Expected Value, Actual Value //To Tally the Business Logic
    }    
}