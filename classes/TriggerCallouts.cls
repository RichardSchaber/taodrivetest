/*
http://cfj-minihack.herokuapp.com

{
  "firstName": "Marc",
  "lastName": "Binioff",
  "email": "ceo@salesforce.com"
  "msg_type": "ceo alert"
}
*/

public class TriggerCallouts{
    @future (callout=true)
    public static void TestExecution(string contactId) {
        Contact contact = [select Id, FirstName, LastName, Email from Contact where Id = :contactId limit 1];
        contact.Email = 'test@testing.com';
        contact.taoDriveTest__jsonResponse__c = 'test';
        contact.taoDriveTest__jsonRequest__c = 'test';
        update contact;
    }
    @future (callout=true)
    public static void TestJSONRequest(string contactId) {
        
        Contact contact = [select Id, FirstName, LastName, Email from Contact where Id = :contactId limit 1];
            
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeStringField('firstName', contact.FirstName );
        gen.writeStringField('lastName', contact.LastName );
        gen.writeStringField('email', contact.Email );
        gen.writeStringField('msg_type', 'ceo alert' );
        gen.writeEndObject();
        
        string jsonString = gen.getAsString();
  
        Http h = new Http();
        string url = 'http://cfj-minihack.herokuapp.com';
        HttpRequest req = new HttpRequest();
        req.setBody(jsonString);
        req.setEndpoint(url);
        req.setMethod('GET');

        HttpResponse res = h.send(req);
        string response = res.getBody();
        contact.taoDriveTest__jsonResponse__c = response;
        contact.taoDriveTest__jsonRequest__c = jsonString;
        update contact;
      }
}