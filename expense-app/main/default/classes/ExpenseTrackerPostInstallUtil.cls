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
    
    global void setAllTxnToTrackingAccount(String name) {
	    List<Tracking_Account__c> taList = [SELECT Id from Tracking_Account__c WHERE Name=:name LIMIT 1];
        if (taList.size() > 0) {
            Id taId = taList[0].Id;
            List<Expense__c> allExpenses = [SELECT Id, Name FROM Expense__c];
            for (Expense__c exp: allExpenses) {
                exp.Tracking_Account__c = taId;
            }
            update allExpenses;
            List<Income__c> allIncome = [SELECT Id, Name FROM Income__c];
            for (Income__c inc: allIncome) {
                inc.Tracking_Account__c = taId;
            }
			update allIncome;            
        }
    }


    
}