import { LightningElement,wire } from 'lwc';

import getUserEntitlements from '@salesforce/apex/EntitlementCompareController.getUserEntitlements';

export default class UserEntitlementList extends LightningElement {

    selectedUser;

    entitlementtoShow;

    gridColumns=[{

        type: 'text',
        fieldName:'name',
        label:'Name',
        initialWidth:300,

    }];

    @wire(getUserEntitlements, { id: '$selectedUser'})
    entitlements({error, data}){
        console.log('>>>>data>>>'+JSON.stringify(data));
        if(data){

            var temp =JSON.parse(JSON.stringify(data).split('children').join('_children'));
            console.log('>>>>>>temp'+JSON.stringify(temp));
            this.entitlementtoShow=temp;
        }

    }

    handleUserSelected(event){

        const userId=event.detail;
        this.selectedUser=userId;
        console.log('userId='+this.selectedUser);

    }

}