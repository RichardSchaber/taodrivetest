global class MockHttpResponseGenerator implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        System.assertEquals('http://cfj-minihack.herokuapp.com', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"foo":"bar"}');
        res.setStatusCode(200);
        return res;
    }
}