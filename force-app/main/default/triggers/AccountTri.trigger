trigger AccountTri on Account (before Insert) {
    
   String profileName = [SELECT Id, Name FROM Profile WHERE Id=:Userinfo.getProfileId()].Name;
         
        for(Account objAcc : trigger.new){
            if(profileName == 'Policy Manager' && objAcc.Rating =='Cold'){
                objAcc.addError('Policy Manager can not create Account Record');
            }
        } 
}