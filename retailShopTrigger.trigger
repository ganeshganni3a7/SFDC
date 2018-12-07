//Syntax : trigger triggerName on <any sobject name (API Name)> (<events>)
//<events> : before / After : insert , update , delete , insert , update , delete , undelete
trigger retailShopTrigger on Retail_Shop__c (before insert , before update , before delete , after insert , after update , after delete , after undelete ) {
	
    if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate) && globalHandler.retailStoreOutletHandlerAfterContext){
        List<id> retailStoreIds = new List<id>();
        for(Retail_Shop__c rs : trigger.new){
            if(trigger.isUpdate){
                system.debug('++++rs.Id+++'+rs.Id+' ++ olMap value +++ '+trigger.oldMap.get(rs.Id).Count_Of_Outlets__c + ' +++ New Map value ++' +trigger.newMap.get(rs.Id).Count_Of_Outlets__c);
                if(trigger.oldMap.get(rs.Id).Count_Of_Outlets__c != trigger.newMap.get(rs.Id).Count_Of_Outlets__c ){
            		system.debug('+++++++ Out Let Count had been updated ++++');
                    retailStoreIds.add(rs.id);
                }    
            } else {
                retailStoreIds.add(rs.id);
            }
        }
        if(!retailStoreIds.isEmpty()){
    		retailStoreObjectHandler.insertNoOfOutlets(retailStoreIds);
            globalHandler.retailStoreOutletHandlerAfterContext = false;
        }
    }
}