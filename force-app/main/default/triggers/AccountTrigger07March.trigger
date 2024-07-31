trigger AccountTrigger07March on Account (before update) {

    if(trigger.isBefore && trigger.isUpdate){
         for(Account objAcc : trigger.new){    
             if(objAcc.Rating == 'Hot' && trigger.oldMap.get(objAcc.Id).Rating == 'Warm'){
                 objAcc.addError('This Account can not be updated as its Old Rating was Warm and new is Hot');
             } 
        }
    }
}