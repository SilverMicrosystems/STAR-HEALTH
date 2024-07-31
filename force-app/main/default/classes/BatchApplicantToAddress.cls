global class BatchApplicantToAddress implements Database.Batchable<sObject>{

	global Database.queryLocator start(Database.BatchableContext BC){
		return Database.getQueryLocator('Select Id, Police_Verification__c, Gender__c from Applicant__c where Police_Verification__c=true');
	}
	
	global void execute(Database.BatchableContext BC, List<Applicant__c> appList){
	
		Map<Id,Applicant__c> appMap = new Map<Id,Applicant__c>(appList);
		
		List<Address__c> adrList = new List<Address__c>();		
		for(Address__c objAdr : [Select Id, City__c, State__c, Country__c,Applicant__c from Address__c where  Applicant__c IN : appMap.keySet()]){
			adrList.add(objAdr);
		}
		
		if(!adrList.isEmpty()){
		
			for(Address__c objAdr : adrList){
				if(appMap.containsKey(objAdr.Applicant__c)){
					if(appMap.get(objAdr.Applicant__c).Gender__c == 'Male'){						
						objAdr.Country__c = 'Bharat';
						objAdr.State__c = 'Maharashtra';
						objAdr.City__c = 'Pune';
					}
					else{
							if(appMap.get(objAdr.Applicant__c).Gender__c == 'Female'){						
									objAdr.Country__c = 'Bharat';
									objAdr.State__c = 'Maharashtra';
									objAdr.City__c = 'Nagpur';
						}
							else{
									objAdr.City__c = null;
							
							}
					
					}
				}
			}
			
			Database.update(adrList, false);
		}
	
	}
	
	global void finish(Database.BatchableContext BC){
	
	}



}