import ballerina/io;
import ballerina/http;


public function main() {    
    openapiClientConfig openapiConfig = {
        serviceUrl: "http://localhost:9090/v1",
        clientConfig: {}
    };
    openapiClient openapiClient = new(openapiConfig);
    //1.get with query param
    Pets resp = openapiClient->listPets(12);
        //result details = mcClient->getMarketContext("42");
    // io:println(resp.toString());
    
    io:println(resp.cloneWithType(json));
    //2. post with string return.
    string creatPet = openapiClient->createPets();
    io:println(creatPet);

    //3.path parameter
    // Pet|Error output =  openapiClient->showPetById("1");
    // io:println(output.cloneWithType(json));
    // Pet|Error output2 =  openapiClient->showPetById("2");
    // io:println(output2.cloneWithType(json));

    //4.path parameter delete with status code
    // http:Accepted deletOut = openapiClient->deletePet("2");
    // io:println(deletOut.statusCode);

    //5.requestBody
    Pet pet1 = {
                id: 1,
                name: "Tommy",
                tag: "Dog"
            };
    http:Response|error rbOut = openapiClient->createPet(pet1);
    if rbOut is http:Response {
        io:println(rbOut.statusCode);
    }

    //
    string getPet  =  openapiClient->getPet();
    io:println(getPet);
    
}