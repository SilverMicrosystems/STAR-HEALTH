trigger QuoteTrigger on Quote (before Insert, before Update){
    
    Set<Id> oppIdSet = new Set<Id>();
    
    if( trigger.isBefore && (trigger.isInsert || trigger.isUpdate)){		
        for(Quote objQt : trigger.new){
            if(objQt.Primary__c){
                
                if(trigger.isInsert){
                    oppIdSet.add(objQt.OpportunityId); // Parent Opp Id
                }
                if(trigger.isUpdate){
                    if(objQt.Primary__c != trigger.oldMap.get(objQt.Id).Primary__c){
                        oppIdSet.add(objQt.OpportunityId);  //Parent Opp Id
                    }
                }
                
            }
        }
        
    }
    
    
    Map<Id, Opportunity> oppMap = new Map<Id, Opportunity>();
    for(Opportunity objOpp : [Select Id, (Select Id from Quotes where Primary__c = true) from Opportunity WHERE Id in : oppIdSet]){
        oppMap.put(objOpp.Id, objOpp);
    }
    
    List<Quote> qList = new List<Quote>();
    
    if( trigger.isBefore && (trigger.isInsert || trigger.isUpdate)){		
        for(Quote objQt : trigger.new){
            if(oppMap.containsKey(objQt.OpportunityId)){
                List<Quote> qtExistingList = oppMap.get(objQt.OpportunityId).Quotes; // Return a List of exiting Quotes
                
                if(!qtExistingList.isEmpty()){
                    for(Quote objExistingQuote : qtExistingList){
                        objExistingQuote.Primary__c = false;
                        qList.add(objExistingQuote);
                    }
                    
                }
                
            }
        }
        
        
        
    }
    if(!qList.isEmpty())
        Database.update(qList, false);
}