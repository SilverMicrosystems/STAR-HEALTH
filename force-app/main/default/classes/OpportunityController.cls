public with sharing class OpportunityController {

    // Method to get a list of opportunities
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunities() {
        try {
            return [SELECT Id, Name, Amount FROM Opportunity LIMIT 100];
        } catch (Exception e) {
            throw new AuraHandledException('Unable to retrieve opportunities: ' + e.getMessage());
        }
    }

    // Method to get details of a specific opportunity by ID
    @AuraEnabled(cacheable=true)
    public static Opportunity getOpportunity(Id opportunityId) {
        try {
            return [
                SELECT Id, Name, Amount 
                FROM Opportunity 
                WHERE Id = :opportunityId
                LIMIT 1
            ];
        } catch (Exception e) {
            throw new AuraHandledException('Unable to retrieve opportunity details: ' + e.getMessage());
        }
    }

    // Method to update an opportunity
    @AuraEnabled
    public static void updateOpportunity(Opportunity opportunity) {
        try {
            update opportunity;
        } catch (Exception e) {
            throw new AuraHandledException('Unable to update opportunity: ' + e.getMessage());
        }
    }

    // Method to approve an opportunity
    @AuraEnabled
    public static void approveOpportunity(Id opportunityId) {
        try {
            Opportunity opp = [SELECT Id, StageName FROM Opportunity WHERE Id = :opportunityId LIMIT 1];
            opp.StageName = 'Closed Won'; // Example stage for approval
            update opp;
        } catch (Exception e) {
            throw new AuraHandledException('Unable to approve opportunity: ' + e.getMessage());
        }
    }

    // Method to reject an opportunity
    @AuraEnabled
    public static void rejectOpportunity(Id opportunityId) {
        try {
            Opportunity opp = [SELECT Id, StageName FROM Opportunity WHERE Id = :opportunityId LIMIT 1];
            opp.StageName = 'Closed Lost'; // Example stage for rejection
            update opp;
        } catch (Exception e) {
            throw new AuraHandledException('Unable to reject opportunity: ' + e.getMessage());
        }
    }
}