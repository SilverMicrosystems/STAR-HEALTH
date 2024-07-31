trigger OpportunityBackupTrigger on Opportunity (before delete) {
    
    List<OpportunityBackup__c> objOppBackList = new List<OpportunityBackup__c>();
        
    if(trigger.isDelete && trigger.isBefore){
        for(Opportunity objOpp : trigger.old){
            OpportunityBackup__c objOppBack = new OpportunityBackup__c();
            objOppBack.OppBackName__c = objOpp.Name;
            objOppBack.OppBackAmount__c = objOpp.Amount;
            
            objOppBackList.add(objOppBack);
        }
        
        if(!objOppBackList.isEmpty())
            Database.Insert(objOppBackList, false);
    }
}