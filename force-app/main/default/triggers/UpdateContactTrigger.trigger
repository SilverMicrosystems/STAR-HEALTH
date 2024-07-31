trigger UpdateContactTrigger on Contact (after update) {

    List<Contact> contactsToUpdate = new List<Contact>();

    for (Contact c : Trigger.new) {

        Contact oldContact = Trigger.oldMap.get(c.Id);

        if (c.LastModifiedDate != oldContact.LastModifiedDate) {

            c.UpdateCount__c = c.UpdateCount__c + 1;

            contactsToUpdate.add(c);

        }

    }

    update contactsToUpdate;

}