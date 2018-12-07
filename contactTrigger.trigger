trigger contactTrigger on Contact (before insert,before update,before delete , after insert, after update , after delete , after undelete) {
    List<contact> newContactsList = new List<contact>();
    if((trigger.isInsert || trigger.isUpdate) && trigger.isBefore){
        for(contact con : trigger.new){
            if(con.accountId != null){
                newContactsList.add(con);
            }
        }
        if(!newContactsList.isEmpty()){
            contactHelper.isPrimaryCheckOnContact(newContactsList,trigger.oldMap,trigger.newMap);
        }
    }
}