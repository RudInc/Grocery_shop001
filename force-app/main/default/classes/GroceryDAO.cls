public class GroceryDAO {
    //return map, where key = product id, value = number of sold items in period between start/end dates. Date value is Transaction's CreatedDate
    public static Map<ID,Integer>getNumberOfSoldProducts(DateTime startDate, DateTime endDate){
        if(endDate == startDate||startDate>endDate) {
            return new Map<ID,Integer>();
        }
        List<AggregateResult> items = [SELECT Product__c, COUNT(id)
                                       FROM Line_Item__c
                                       WHERE Transaction__r.CreatedDate > :startDate AND Transaction__r.CreatedDate <:endDate
                                       GROUP BY Product__c]; 
        Map<ID, Integer>res = new Map<ID, Integer>();
        for(AggregateResult i :items){
            res.put((ID)i.get('Product__c'),(Integer)i.get('expr0'));
        }
        return res;
    }
    //return map, where key = transaction id, value = amount of money of all line items related to this trasaction.
    
    public static Map<ID,Decimal> getTotalAmountOfTransactions(Set<Id> trsIds){
        if(trsIds.isEmpty()) {
            return new Map<ID,Decimal>();
        }
        List<Transaction__c> trs = [SELECT ID, Total_Amount__c FROM Transaction__c WHERE ID IN: trsIds];
        Map<ID,Decimal> res = new Map<ID,Decimal>();
        for(Transaction__c i: trs){
            res.put(i.ID, i.Total_Amount__c);
        }
        return res;
    }
    //return  10 most profitable transactions (based on "total amount")
    @AuraEnabled
    public static List<Transaction__c> getMostProfitableTransactions(){
        return [SELECT ID,Name, Total_Amount__c, Status__c, CreatedDate 
                FROM Transaction__c
                WHERE Status__c IN ('Active','Closed')
                ORDER BY Total_Amount__c DESC
                LIMIT 10]; 
    }
    //get top sold products of specified year. Ordered by - most seller at top.
    public static List<Line_Item__c> getTopSellers(Integer limitNumber, Integer offsetNumber, Integer year){
        if(limitNumber <1|| offsetNumber<1) {
            return new List<Line_Item__c>();
        }
        return [SELECT Product__r.Name, Amount__c
                FROM Line_Item__c
                WHERE CALENDAR_YEAR(CreatedDate) = :year
                ORDER BY Amount__c DESC
               	LIMIT :limitNumber OFFSET:offsetNumber];
    }
     //how many products where bought with visa/masatercard? return result, groupped by payment type
    public static List<AggregateResult> getPaymentStatisticsAmount(){
        return [SELECT Payment_Type__c, COUNT(id)
                FROM Transaction__c
                GROUP BY Payment_Type__c];
    }
    //get all products
    public static List<Product__c> getProducts(Integer limitNumber, Integer offsetNumber){
        if(limitNumber <1|| offsetNumber<1) {
            return new List<Product__c>();
        }
        return [SELECT Name, Code__c, Price__c, Available_Amount__c 
                FROM Product__c 
                LIMIT :limitNumber OFFSET :offsetNumber];
    }
    //get all products with Available_Amount__c> 0
    public static List<Product__c> getProductAvailableInStore(Integer limitNumber, Integer offsetNumber ){
        if(limitNumber <1|| offsetNumber<1) {
            return new List<Product__c>();
        }
        return [SELECT Name, Code__c, Price__c, Available_Amount__c 
                FROM Product__c 
                WHERE Available_Amount__c > 0
                LIMIT :limitNumber OFFSET :offsetNumber];
    }
    //get all line items related to inputed transaction
    @AuraEnabled
    public static List<Line_Item__c> getLineItemsByTransaction(ID transactionId){
       return [SELECT ID, Name, Product_Name_With_Code__c, Quantity__c, Amount__c 
               FROM Line_Item__c 
               WHERE Transaction__c =:transactionId];
    }
 
}