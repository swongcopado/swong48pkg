@isTest
public class ExpenseTrackerPostInstallUtilTest {
    @isTest
    static public void testOnInstall() {
        AggregateResult[] arList = [SELECT COUNT(ID) from Tracking_Account__c];
        Integer count = arList.size();
        Integer expectedResult = count;
        ExpenseTrackerPostInstallUtil obj = new ExpenseTrackerPostInstallUtil();
        obj.onInstall(null);
        arList = [SELECT COUNT(ID) from Tracking_Account__c];
        Integer actualCount = arList.size();
        System.assertEquals(expectedResult, actualCount, 'Test passed');
    }
    
    @isTest
    static public void testSetTrackingAccount() {
        ExpenseTrackerPostInstallUtil obj = new ExpenseTrackerPostInstallUtil();
        Expense__c testExpense = new Expense__c(Name='Test', 
                                                Amount__c=99, 
                                                Type__c='Household', 
                                                Sub_Type__c='Groceries'
                                                );
  
        Tracking_Account__c ta = new Tracking_Account__c(Name='Australia');
        insert ta;
        testExpense.Tracking_Account__c = ta.Id;
        insert testExpense;
        
        Tracking_Account__c tb = new Tracking_Account__c(Name='Malaysia');
		insert tb;
        
		obj.setAllTxnToTrackingAccount('Malaysia');        
        List<Expense__c> expenses = [SELECT Tracking_Account__c from Expense__c];        
        BOOLEAN pass = true;
        for (Expense__c e: expenses) {
            if (e.Tracking_Account__c != tb.Id) {
                pass = false;
            }
        }
        System.assertEquals(pass,true,'Not all records were updated');
    }
}