// CaseController.cls
public without sharing class CaseController {
    @AuraEnabled(cacheable=true)
    public static List<Case> getCases(String caseNumber) {
        return [SELECT Id, CaseNumber, Subject, Status FROM Case WHERE CaseNumber = :caseNumber];
    }

    @AuraEnabled 
    public static List<Case> getStatus(String caseStatus){
        return [SELECT Id, CaseNumber, Priority, Status FROM Case WHERE Status = :caseStatus];
    }
}