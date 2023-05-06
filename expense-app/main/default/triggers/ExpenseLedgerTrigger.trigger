trigger ExpenseLedgerTrigger on Expense__c (before insert, before update) {
    
    for (Expense__c expense : Trigger.new) {
        expense = ExpenseTrackerTools.LinkExpenseToLedger(expense);
    }

}