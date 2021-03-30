import ballerina/http;

public type openapiClientConfig record {
    string serviceUrl;
    http:ClientConfiguration clientConfig;
};

public client class openapiClient {
    public http:Client clientEp;
    public openapiClientConfig config;

    public function init(openapiClientConfig config) {
        http:Client httpEp = checkpanic new(config.serviceUrl, {auth: config.clientConfig.auth, cache:
            config.clientConfig.cache});
        self.clientEp = httpEp;
        self.config = config;
    }

    //1.service with query parameters limit , 'limit
    remote function listPets(int 'limit) returns Pets {
        http:Client listPetsEp = self.clientEp;
        //Check if qutedIdntifer there , if there then remove and take name 
        Pets response = checkpanic listPetsEp->get(string `/pets?limit=${'limit}`, targetType = Pets);
        
        return response;
    }
    // post return with string
    remote function createPets() returns string {
        http:Client createPetsEp = self.clientEp;
        
        //post message mapped to response description.
        string response = checkpanic createPetsEp->post("/pets","successful", targetType = string);
        return response;
    }
    
    //client cant be with multiple value
    // remote function showPetById(string petId) returns Pet|Error {
    //     http:Client showPetByIdEp = self.clientEp;
    //     Pet|Error response = checkpanic showPetByIdEp->get(string `/pets/${petId}`, targetType = Pet|Error);
    //     return response;
    // }

    remote function showPetById(string petId) returns http:Response {
        http:Client showPetByIdEp = self.clientEp;
        http:Response response = checkpanic showPetByIdEp->get(string `/pets/${petId}`, targetType = http:Response);
        // if response is http:Response {
            // handle the given payload and return
        // }
        return response;
    }

    //targetType map payload this depends on the user intention what is is going to do with this .
    // if he wants to access more details better option to use is http:Response or error.
    // if he just need to check status or payload msg it is okey to return boolean value by checking status code/
    // remote function deletePet(int petId) returns boolean {
        // http:Client deletePetEp = self.clientEp;
        //can't use http:Accepted in targetType.
        // http:Accepted response = check deletePetEp->delete(string `/pets/${petId}`, targetType = http:Accepted);
        // return http:Accepted;
        // return true;
    // }

//request body
    remote function createPet(Pet createPetBody) returns http:Response {
        http:Client createPetEp = self.clientEp;
        http:Request request = new;
        json createPetJsonBody = checkpanic createPetBody.cloneWithType(json);
        request.setPayload(createPetJsonBody);

        // TODO: Update the request as needed
        http:Response response = checkpanic createPetEp->post("/pet", request);
        return response;
    }

    remote function getPet() returns string {
        http:Client listPetsEp = self.clientEp;
        //Check if qutedIdntifer there , if there then remove and take name 
        string response = checkpanic listPetsEp->get("/pet", targetType = string);
        
        return response;
    }
}