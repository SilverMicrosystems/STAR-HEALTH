trigger LeadTrigger on Lead (before insert, before update) {

    for(Lead objLead : trigger.new){
        if(objLead.MobilePhone != null){
            
        }
    }
}