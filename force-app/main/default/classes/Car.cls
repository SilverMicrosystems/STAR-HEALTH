public with sharing class Car {
    
    @testVisible
    private static String fullName(String prefix, String firstName, String lastName){ //Mr , Amit , Prakash
        return prefix+'.'+firstName+' '+lastName; // Mr.Amit Prakash
    }
}