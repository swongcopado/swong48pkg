global class ExpenseTrackerPostInstallUtil implements InstallHandler {
    global void onInstall(InstallContext context) {
        List<Tracking_Account__c> resultArray = [SELECT Id, Name from Tracking_Account__c];
        Integer count = resultArray.size();
        System.debug('Tracking Accounts Loaded: '+count);
        if (count==0) {
            // No records yet, so insert them.
            Tracking_Account__c auTC = new Tracking_Account__c(Name='Australia');
            Tracking_Account__c myTC = new Tracking_Account__c(Name='Malaysia');
            List<Tracking_Account__c> tcList = new List<Tracking_Account__c>();
            tcList.add(auTC);
            tcList.add(myTC);
            
            Database.insert(tcList);
            
        }
    }

}