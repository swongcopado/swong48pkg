trigger IncomeLedgerTrigger on Income__c (before insert, before update) {
    
    for (Income__c income : Trigger.new) {
        income = ExpenseTrackerTools.LinkIncomeToLedger(income);
    }

}