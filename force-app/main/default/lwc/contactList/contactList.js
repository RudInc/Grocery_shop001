import { LightningElement, wire } from 'lwc';
import  getContacts  from "@salesforce/apex/ContactController.getContacts";
import CONTACT_FIRSTNAME_FIELD from "@salesforce/schema/Contact.FirstName";
import CONTACT_LASTNAME_FIELD from "@salesforce/schema/Contact.LastName";
import CONTACT_EMAIL_FIELD from "@salesforce/schema/Contact.Email";

export default class ContactList extends LightningElement {
    columns = [
        {label: "First Name", fieldName: CONTACT_FIRSTNAME_FIELD.fieldApiName, type:"text"},
        {label: "Last Name", fieldName: CONTACT_LASTNAME_FIELD.fieldApiName, type:"text"},
        {label: "Email", fieldName:CONTACT_EMAIL_FIELD.fieldApiName, type:"text"},
    ];
    
    @wire(getContacts) contacts;
}