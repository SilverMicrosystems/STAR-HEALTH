trigger AccountTrigger05March on Account (before insert, after insert, before update, after update,before delete, after delete, after undelete) {
    
    if(trigger.isBefore && trigger.isInsert){
        System.debug('INSERT OPERATION : LIST<ACCOUNT>: '+trigger.new);    //List of New Version of the Records
    }
    
    if(trigger.isAfter && trigger.isInsert){
        System.debug('INSERT OPERATION : LIST<ACCOUNT>: '+trigger.new);    //List of New Version of the Records
        System.debug('UPDATE OPERATION MAP<ID, ACCOUNT>: '+trigger.newMap); //Map of New Version of the Records
    }
    
    if(trigger.isUpdate){
        System.debug('UPDATE OPERATION LIST<ACCOUNT>: '+trigger.new);    //List of New Version of the Records
        System.debug('UPDATE OPERATION MAP<ID, ACCOUNT>: '+trigger.newMap); //Map of New Version of the Records
        
         System.debug('UPDATE OPERATION LIST<ACCOUNT> : '+trigger.old);    //List of Old Version of the Records
        System.debug('UPDATE OPERATION MAP<ID,ACCOUNT>: '+trigger.oldMap); //Map of Old Version of the Records
    }
    
    if(trigger.isDelete){
        System.debug('DELETE OPERATION LIST<ACCOUNT> : '+trigger.old);    //List of Old Version of the Records
        System.debug('DELETE OPERATION MAP<ID,ACCOUNT>: '+trigger.oldMap); //Map of Old Version of the Records
    }
    
    if(trigger.isUndelete){
        System.debug('UNDELETE OPERATION LIST<ACCOUNT>: '+trigger.new);        //List of New Version of the Records
        System.debug('UPDATE OPERATION MAP<ID, ACCOUNT>: '+trigger.newMap); //Map of New Version of the Records
    }
    
    
    
}