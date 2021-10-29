@isTest
public class GetNumberOfSoldProductsTest {
    @testSetup static void testSetup(){
        List<Transaction__c> setupTransactions = TestDataFactory.generateTransactions(15,'Active');
        List<Product__c> setupProduct = TestDataFactory.generateProducts(3,10,1000);
        Integer daysToAdd = 0;
        insert setupTransactions;
        insert setupProduct;
        List<Line_Item__c> setupItems = new List<Line_item__c>(); 
        for(Product__c prod : setupProduct){
            for(Transaction__c trans : setupTransactions){
                setupItems.addAll(TestDataFactory.generateLineItems(3,5,trans.ID,prod.ID));
            }
        }
        insert setupItems;
        for(Transaction__c trans : setupTransactions){
            Test.setCreatedDate(trans.id, Date.newInstance(2021, 1, 1).addDays(daysToAdd));
            daysToAdd +=15;
        }
        
    }
    @isTest static void validDates(){
        
        Date startDate = Date.newInstance(2021, 2, 1);
        Date endDate = Date.newInstance(2021, 4, 1);
        List<AggregateResult> items = [SELECT Product__c, COUNT(id)
                                       FROM Line_Item__c
                                       WHERE Transaction__r.CreatedDate > :startDate AND Transaction__r.CreatedDate <:endDate
                                       GROUP BY Product__c];
        Map<ID, Integer>resToTest = new Map<ID, Integer>();
        for(AggregateResult item :items){
            resToTest.put((ID)item.get('Product__c'),(Integer)item.get('expr0'));
        }
        Test.startTest();
        Map<Id,Integer> result = GroceryDAO.getNumberOfSoldProducts(startDate, endDate);
        for(Id resId : result.keySet()){
            system.debug('resToTest ' + resToTest.get(resId));
            system.debug(' result '+result.get(resId));
            System.assertEquals(resToTest.get(resId), result.get(resId));
        }
        Test.stopTest();

    }
    @isTest static void invalidlDates(){
        Date startDate = Date.newInstance(2021, 4, 1);
        Date endDate = Date.newInstance(2021, 2, 1);
        Map<ID, Integer>resToTest = new Map<ID, Integer>();
        Map<Id,Integer> result = GroceryDAO.getNumberOfSoldProducts(startDate, endDate);
        System.assertEquals(resToTest,result);
        
    }
    @isTest static void equalDates(){
        Date startDate = Date.newInstance(2021, 2, 1);
        Date endDate = Date.newInstance(2021, 2, 1);
        Map<ID, Integer>resToTest = new Map<ID, Integer>();
        Map<Id,Integer> result = GroceryDAO.getNumberOfSoldProducts(startDate, endDate);
        System.assertEquals(resToTest,result);
    }

}