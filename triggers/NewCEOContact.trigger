trigger NewCEOContact on Contact (after insert) {

	Contact[] contacts = Trigger.new;
    for(Contact c : contacts){
        TriggerCallouts.TestJSONRequest(c.Id);
    }
}