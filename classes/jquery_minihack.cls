public with sharing class jquery_minihack {
	public Opportunity theOpp {get;set;}
	public List<PricebookEntry> allStandardProducts {get;set;} 
	public List<Products> allProducts {get;set;}
	public List<Products> selectedProducts {get;set;}
	public List<OpportunityLineItem> allProductsToAdd {get;set;}

    public Products dragProduct {get;set;}
    public integer draggedRowIndex {get;set;}
	
	public jquery_minihack(ApexPages.StandardController std){
		theOpp = (Opportunity) std.getRecord();
		allProducts = new List<Products>();
		selectedProducts = new List<Products>();
		allProductsToAdd = new List<OpportunityLineItem>();
		allStandardProducts = [select Name, Id, Product2.ProductCode, UnitPrice from PricebookEntry where Pricebook2.Name = 'Standard'];
		createProductList();
	}
	
    public void setDraggedProduct(){
    	dragProduct = allProducts[draggedRowIndex];
        dragProduct.quantity = 1;
    }
    
	/* creates a table with checkboxes for all standard products */
	public void createProductList(){
		for(PricebookEntry product : allStandardProducts) {
			allProducts.add(new Products(false, product, 0, product.UnitPrice));
		}
	}

    public void addProduct(){
        selectedProducts.add(dragProduct);
    }
	
	/* link products to opportunity */
	public pageReference createLineItems(){
		for(Products product : selectedProducts){
			OpportunityLineItem oli = new OpportunityLineItem(
				Quantity = product.quantity,
				UnitPrice = product.SalesPrice,
				OpportunityId = theOpp.Id,
				PricebookEntryId = product.prod.Id
			);
			
			allProductsToAdd.add(oli);
		}
		
		insert allProductsToAdd;
		return new PageReference('/apex/jquery_minihack?id='+theOpp.Id).setRedirect(true);
	}
	
	/* wrapper class for all standard products table */
	public class Products {
		public boolean selected {get;set;}
		public PricebookEntry prod {get;set;}
		public Integer quantity {get;set;}
		public Decimal SalesPrice {get;set;}
		
		public Products(boolean checkbox, PricebookEntry pricebookentry, Integer product_quantity, Decimal product_salesprice){
			selected = checkbox;
			prod = pricebookentry;
			quantity = product_quantity;
			SalesPrice = product_salesprice;
		}
	}
}