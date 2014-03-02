@isTest
private class testTrigger{
      @isTest static void testTrigger(){
          Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
          Contact c = new Contact();
          c.FirstName = 'Marc';
          c.LastName = 'Binioff';
          c.Email = 'ceo@salesforce.com';
          test.startTest();
          insert c;
          test.stopTest();
          System.assertNotEquals(c.taoDriveTest__jsonResponse__c,''); 
      }
}