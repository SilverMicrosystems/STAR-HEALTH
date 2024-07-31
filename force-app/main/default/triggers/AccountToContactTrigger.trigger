trigger AccountToContactTrigger on Account (after update) {

    Map<Id,Account> accMap = new Map<Id,Account>();
    if(trigger.isUpdate && trigger.isAfter){
        for(Account objAcc : trigger.new){
            accMap.put(objAcc.Id, objAcc);
        }
    }
    
    List<Contact> conExistingList = new List<Contact>();
    for(Contact objCon : [Select Id, MobilePhone,AccountId from Contact Where  AccountId IN : accMap.keySet()]){
        conExistingList.add(objCon);
    }
    
    for(Contact objCon : conExistingList){
        if(accMap.containsKey(objCon.AccountId)){
            objCon.MobilePhone = accMap.get(objCon.AccountId).Phone;
        }
    }
    
    Database.update(conExistingList, false);
    
    
}