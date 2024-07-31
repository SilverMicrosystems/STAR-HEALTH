trigger AccountTriggerPreventDeletion on Account (before delete) {

    if(trigger.isBefore && trigger.isDelete){
        for(Account objAcc : trigger.old){
            if(objAcc.Rating == 'Hot'){
                objAcc.addError(objAcc.Name+' This Account can not be deleted as Rating is Hot');
            }
        }
    }
}