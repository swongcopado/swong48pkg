@isTest
public with sharing class ExpensesUtilityTest {

    @isTest
    static public void testSetDefaultAdditionalInfo() {
        @startTest
        Expenses__c exp = new Expenses__c();
        exp.Date__c = new Date();
        exp.Amount__c = 99.99;
        exp = ExpensesUtility.setDefaultAdditionalInfo(exp);
        System.assertEquals('Yet another expense', exp.Additional_Info__c, 'Default Additional info set incorrectly');
    }

}
