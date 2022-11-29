public with sharing class ExpensesUtility {
    
    static public Expenses__c setDefaultAdditionalInfo(Expenses__c obj) {
        String description = 'Yet another expense';
        obj.Additional_Info__c = description;
        return obj;
    }

}
