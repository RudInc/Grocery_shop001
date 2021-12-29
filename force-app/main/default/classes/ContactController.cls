public with sharing class ContactController {
    public ContactController() {

    }
    @AuraEnabled(cacheable=true)
    public static Contact[] getContacts(){
        return [SELECT FirstName, LastName, Email FROM Contact];
    }
}
