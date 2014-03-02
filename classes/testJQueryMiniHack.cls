@isTest(SeeAllData=true)
private class testJQueryMiniHack{
      @isTest static void RunTest(){
          PageReference pageRef = Page.jQuery_minihack;
          Test.setCurrentPage(pageRef);
          Opportunity theOpp = new Opportunity();
          theOpp.Name = 'testOpp';
          theOpp.StageName = 'Prospecting';
          theOpp.CloseDate = date.today();
          insert theOpp;
          ApexPages.StandardController sc = new ApexPages.StandardController(theOpp );
          jquery_minihack jqmh = new jquery_minihack(sc);
          jqmh.draggedRowIndex = 0;
          jqmh.setDraggedProduct();
          jqmh.addProduct();
          PageReference pr = jqmh.createLineItems();
      }
}