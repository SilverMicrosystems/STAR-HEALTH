trigger ContactTriggerSendNSDL on Contact (after insert) {

    SET<Id> conIdSet = new SET<ID>();
    for(Contact objCon : trigger.new){
        conIdSet.add(objCon.Id);
    }
    
    ContactTriggerSendNSDLHandlerAPI.sendContactToNSDLTarget(conIdSet);
    
    
}