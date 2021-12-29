import { LightningElement } from 'lwc';

import getProductsByName from '@salesforce/apex/ProductController.getProductsByName';

export default class ProductsSearch extends LightningElement {
    productName;
    products = [];

    handleInputChange(event){
        this.productName = event.detail.value;
        setTimeout(()=>{
            getProductsByName({productName:('%' + this.productName + '%')})
            .then( result=> {
                this.products = result;
            })
            .catch(error=>{
                this.products = [];
                alert(error);
            });
        });
        
    }
    handleAddItem(event){
        
        const addItemEvent = new CustomEvent("additem",({
            detail : {
                productId : event.detail.productId,
                productName : event.detail.productName,
                productQuantity: event.detail.productQuantity,
                productPrice: event.detail.productPrice
            }

        }));
        this.dispatchEvent(addItemEvent);
    }

}