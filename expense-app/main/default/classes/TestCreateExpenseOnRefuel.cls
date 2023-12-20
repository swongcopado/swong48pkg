@isTest
private class TestCreateExpenseOnRefuel {
    @isTest
    static void testCreateExpenseOnRefuel() {
        // Set up test data
        // This is a test Refuel_Entry__c record
        
        Date dtToday = Date.today();
        String ledgerName = ExpenseTrackerTools.getLedgerName(dtToday.Year(), 
                                                              dtToday.Month(),
                                                              'Australia');

        Ledger__c testLedger = new Ledger__c(Name=ledgerName,Date__c=dtToday,Country__c='Australia'); 
        Vehicle__c testVehicle = new Vehicle__c(Name = 'DUMMYCAR',Purchased_Date__c=Date.Today());
        
		insert testLedger;
        insert testVehicle;
        // Insert the test Refuel_Entry__c record
        Re_fuel_Entry__c testRefuelEntry = new Re_fuel_Entry__c(
            Odometer__c = 900,
            Litres__c = 60.00,
            Price_per_litre__c = 2.0,
            Vehicle__c = testVehicle.Id, 
            Date__c = Date.today()
        );

        // Start the test context
        Test.startTest();
        
        insert testRefuelEntry;
        
        // Stop the test context
        Test.stopTest();

        // Query for the created Expense__c record
        List<Expense__c> expenses = [SELECT Name, Amount__c, Date__c FROM Expense__c WHERE Name = 'Costco'];
        List<Re_Fuel_Entry__c> refuelEntries = [SELECT Name, Amount__c, Date__c FROM Re_Fuel_Entry__c WHERE Vehicle__c = :testVehicle.Id];

        // Assert that one Expense__c record was created
        System.assertEquals(1, expenses.size(), 'One Expense record should be created');
        System.assertEquals(1, refuelEntries.size(), 'One Test Refuel Entry should be created');

        // Assert that the fields on the Expense__c record have the correct values
        Expense__c createdExpense = expenses[0];
        Re_Fuel_Entry__c refuelEntry = refuelEntries[0];
        System.assertEquals('Costco', createdExpense.Name, 'The Expense Name should be Costco');
        System.assertEquals(refuelEntry.Amount__c, createdExpense.Amount__c, 'The Expense Amount should match the Refuel Entry Amount');
        System.assertEquals(refuelEntry.Date__c, createdExpense.Date__c, 'The Expense Date should match the Refuel Entry Date');
    }
}