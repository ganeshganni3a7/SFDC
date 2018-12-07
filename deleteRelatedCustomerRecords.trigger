trigger deleteRelatedCustomerRecords on Retail_Shop__c (before delete) {
    set<id> retailShopIds = new Set<id>();
    for(Retail_Shop__c r : trigger.old){
        system.debug(' +++ Deleted Records ++ '+trigger.old);
        retailShopIds.add(r.id);
    }
    if(!retailShopIds.isEmpty()){
        delete [select id from Customers__c where Retail_Shop__c IN:retailShopIds];
    }
}