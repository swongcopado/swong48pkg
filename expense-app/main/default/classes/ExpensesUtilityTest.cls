@isTest
public class ExpensesUtilityTest {

    // This is the test method
    @isTest
    static public void testSetDefaultAdditionalInfo() {
        Test.startTest();
        Expense__c exp = new Expense__c();
        exp.Date__c = Date.Today();
        exp.Amount__c = 99.99;
        exp = ExpensesUtility.setDefaultAdditionalInfo(exp);
        System.assertEquals('Yet another expense', exp.Additional_Info__c, 'Default Additional info set incorrectly');
        Test.stopTest();
    }

}