({
    addItem : function(component) {
        let item ={
            productId : component.get("v.productId"),
            quantity : component.get("v.quantity")
        }
        let items = component.get("v.items");
        items.push(item);
        component.set("v.items",items);
    }
})
