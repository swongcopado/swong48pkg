trigger CreateExpenseOnRefuel on Re_fuel_Entry__c (before insert) {
    // Prepare a list to hold the new Expense__c records
    List<Expense__c> expensesToInsert = new List<Expense__c>();
    

    // Loop through each Refuel_Entry__c record that was inserted
    for (Re_fuel_Entry__c refuelEntry : Trigger.new) {

        String ledgerName = ExpenseTrackerTools.getLedgerName(refuelEntry.Date__c.Year(), 
                                                              refuelEntry.Date__c.Month(),
                                                              'Australia');
        
        Ledger__c ledger = [SELECT Id, Name from Ledger__c where Name = :ledgerName];
        Vehicle__c vehicle = [SELECT Name from Vehicle__c where Id = :refuelEntry.Vehicle__c];
        String addInfo = 'Refuel - Vehicle: ' + vehicle.Name + 
            			 ', Litres: ' + refuelEntry.Litres__c + 
             			 ', Price per litre: ' + refuelEntry.Price_per_litre__c + 
            			 ', Odometer: ' + refuelEntry.Odometer__c;

        // Create a new Expense__c record
        Expense__c newExpense = new Expense__c(Name = 'Costco',
                                               Amount__c = refuelEntry.Amount__c,
                                               Date__c = refuelEntry.Date__c,
                                               Ledger__c = ledger.Id,
                                               Type__c = 'Household',
                                               Sub_Type__c = 'Travel',
                                               Additional_Info__c = addInfo);

        // Add the new Expense__c record to the list
        expensesToInsert.add(newExpense);
    }

    // Insert the new Expense__c records
    if (!expensesToInsert.isEmpty()) {
        insert expensesToInsert;
    }
}