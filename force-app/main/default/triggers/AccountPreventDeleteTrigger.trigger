trigger AccountPreventDeleteTrigger on Account (after Insert) {
    
    for(Account objAcc : trigger.new){
        System.debug(objAcc.Name);
    }
}