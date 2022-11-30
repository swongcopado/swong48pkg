public with sharing class ExpensesUtility {
    
    static public Expense__c setDefaultAdditionalInfo(Expense__c obj) {
        String description = 'Yet another expense';
        obj.Additional_Info__c = description;
        return obj;
    }

}