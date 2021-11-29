public class LineItemsCallouts {
    /*Get all Line Items from the external app using HTTP Request and display them in the table which has been created as a part of LWC.*/
    @AuraEnabled
    public static List<Object> getLineItemsFromExternalApp(String link) {
		Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint(link);
        request.setHeader('projectName' , 'GroceryStore');
        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 200){
            List<LineItemWrapper> items = (List<LineItemWrapper>)JSON.deserialize(response.getBody(), List<LineItemWrapper>.class);
            
            return items;
        }else{
            return null;
        }
            
    }
    //"quantity":4,"amount":289,"productName":"Fish","transactionNumber":32134,"productCode":"F-{001}"}
    public class LineItemWrapper{
        @AuraEnabled public Integer quantity{get;set;}
        @AuraEnabled public Integer amount{get;set;}
        @AuraEnabled public String  productName{get;set;}
        @AuraEnabled public Integer transactionNumber{get;set;}
        @AuraEnabled public String productCode{get;set;}
        public LineItemWrapper(){

        }
    }
}