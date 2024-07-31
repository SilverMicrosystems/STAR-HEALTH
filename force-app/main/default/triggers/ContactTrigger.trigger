trigger ContactTrigger on Contact (after insert) {

    Set<Id> contactIdSet = new Set<Id>();
    for(Contact objCon : trigger.new){//10
        if(objCon.MobilePhone != null)
            contactIdSet.add(objCon.id);//10
    }
    
    
    MobileVerificationRequestAPI.verifiyMobileNumber(contactIdSet);// Sending Set of ContactId
    
}