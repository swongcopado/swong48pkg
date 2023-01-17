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

}