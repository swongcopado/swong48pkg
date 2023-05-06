public class ExpenseTrackerTools {
   
    static public String getLedgerName(Integer year, Integer month) {
        // This method gets the Ledger Name in the format yyyy-mm
        String ledgerName = String.valueOf(year);
        ledgerName += '-';
        IF (month < 10) {
            ledgerName+='0';
        } 
        ledgerName+=String.valueOf(month);
        return ledgerName;
    }
    
    static public void CreateYearlyLedgers(Integer year) {
        
        List<Ledger__c>ledgers = new List<Ledger__c>();
        
        ledgers = [SELECT Id, Name, Date__c from Ledger__c where Year__c = :year];
        If (ledgers.size() > 0) {
            // ledger entries already exist
            return;
        }
        
        FOR (Integer month=1; month <=12; month++) {
            String ledgerName = ExpenseTrackerTools.getLedgerName(year,month);
        	Ledger__c ledger = new Ledger__c(Name=ledgerName,Date__c=Date.newInstance(year, month, 1)); 
            ledgers.add(ledger);
        }
        upsert ledgers;
    }
    
    static public void LinkTransactionsToLedger() {
        // This utility is to link all existing Transactions (Expenses and Incomes) to the Ledger Lookup field that has just been added
        
        List<Ledger__c> ledgers = [SELECT Id, Name, Month__c, Year__c FROM Ledger__c];
        Map<String,Ledger__c> ledgerMap = new Map<String,Ledger__c>();
        FOR (Ledger__c eachLedger : ledgers) {
            ledgerMap.put(eachLedger.Name,eachLedger);
        }
        
        List<Expense__c> expenses = [SELECT Id,Name,Date__c,Ledger__c FROM Expense__c];
        FOR (Expense__c eachExpense : expenses ) {
            Integer expenseMonth = eachExpense.Date__c.Month();
            Integer expenseYear = eachExpense.Date__c.Year();
            String ledgerKey = ExpenseTrackerTools.getLedgerName(expenseYear, expenseMonth);
            Ledger__c ledger = ledgerMap.get(ledgerKey);
            IF (ledger!=null) {
				eachExpense.Ledger__c = ledger.Id;
            }
        }

        List<Income__c> incomes = [SELECT Id,Name,Date__c,Ledger__c FROM Income__c];
        FOR (Income__c eachIncome : incomes ) {
            Integer incomeMonth = eachIncome.Date__c.Month();
            Integer incomeYear = eachIncome.Date__c.Year();
            String ledgerKey = ExpenseTrackerTools.getLedgerName(incomeYear, incomeMonth);
            Ledger__c ledger = ledgerMap.get(ledgerKey);
            IF (ledger!=null) {
				eachIncome.Ledger__c = ledger.Id;
            }
        }

        upsert ledgers;
        upsert expenses;
        upsert incomes;
    }
    
    static public Expense__c LinkExpenseToLedger(Expense__c exp) {
        String ledgerName = ExpenseTrackerTools.getLedgerName(exp.Date__c.Year(), exp.Date__c.Month());
        List<Ledger__c> ledger = [SELECT Id, Name from Ledger__c WHERE Name = :ledgerName];
        if (ledger.size()>0) {
            exp.Ledger__c = ledger[0].Id;
        }
        
        return exp;
    }

    static public Income__c LinkIncomeToLedger(Income__c inc) {
        String ledgerName = ExpenseTrackerTools.getLedgerName(inc.Date__c.Year(), inc.Date__c.Month());
        List<Ledger__c> ledger = [SELECT Id, Name from Ledger__c WHERE Name = :ledgerName];
        if (ledger.size()>0) {
            inc.Ledger__c = ledger[0].Id;
        }
        
        return inc;
    }    
    
}