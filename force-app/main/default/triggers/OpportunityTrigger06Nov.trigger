trigger OpportunityTrigger06Nov on Opportunity (before update) {
    
    if(trigger.isBefore && trigger.isUpdate){
        for(Opportunity objOpp : trigger.new){
          
  if(objOpp.StageName =='Closed Won' && trigger.oldMap.get(objOpp.Id).StageName == 'Closed Lost'){
                objOpp.Description = 'Yahoo.....!!!!';
            }
            else{
                objOpp.Description = null;
            }
        }
    }
}