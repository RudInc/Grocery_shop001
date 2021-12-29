import { LightningElement } from 'lwc';
import getCustomerByName from '@salesforce/apex/customerController.getCustomerByName';

export default class CustomerSearch extends LightningElement {
    customerName;
    columns = [
        { label: 'ID', fieldName: 'Id', type: 'text' },
        { label: 'Name', fieldName: 'Name', type: 'text' },
        { label: 'Bonus', fieldName: 'Bonus__c', type: 'integer' }
    ];
    customers = [];
    choose = false;
    handleInputChange(event){
        this.customerName= event.detail.value;
        setTimeout (()=>{
            getCustomerByName({customerName:('%' + this.customerName + '%')})
            .then( result=> {
                this.customers = result;
            })
            .catch(error =>{
                this.customers=[];
                alert(error);
            });
        }, 300);
        
    }
    chooseCustomerHandler(event){
        this.choose = true;
        this.customers = [JSON.parse(event.detail)];
        
        const chooseCustomerEvent = new CustomEvent('choosecustomer',{
            detail: this.customers[0].Id
        });
        this.dispatchEvent(chooseCustomerEvent);
    }
    dismissHandler(){
        this.choose = false;
        this.customers = [];

        const dismissEvent = new CustomEvent('dismisscustomer');
        this.dispatchEvent(dismissEvent);
    }
}
