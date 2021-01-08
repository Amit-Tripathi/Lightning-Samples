import { LightningElement,wire,api } from 'lwc';
import getActiveUsers from '@salesforce/apex/EntitlementCompareController.getActiveUsers';

export default class SelectOperator extends LightningElement {
    @wire(getActiveUsers)
    users;

    @api label;

    get userValues(){
        return this.users.data;
    }

    handleChange(event){
        console.log('Selected User Id='+event.detail.value);
        const userSelected= new CustomEvent('userselected',{ detail: event.detail.value });
        this.dispatchEvent(userSelected);
 
    }
    
}