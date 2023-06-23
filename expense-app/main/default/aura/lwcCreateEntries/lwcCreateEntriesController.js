({
createExpenseRecord : function(component, event, helper) {
	var createRecordEvent = $A.get("e.force:createRecord");
    createRecordEvent.setParams({"entityApiName": "Expense__c"});
    createRecordEvent.fire();    },
createIncomeRecord : function(component, event, helper) {
	var createRecordEvent = $A.get("e.force:createRecord");
    createRecordEvent.setParams({"entityApiName": "Income__c"});
    createRecordEvent.fire();    },
createRefuelEntryRecord : function(component, event, helper) {
	var createRecordEvent = $A.get("e.force:createRecord");
    createRecordEvent.setParams({"entityApiName": "Re_fuel_Entry__c"});
    createRecordEvent.fire();    },
})