import ballerina/http;
import ballerina/io;

listener http:Listener ep0 = new (9090, config = {host: "localhost"});

service /v1 on ep0 {
    resource function get pets(int 'limit) returns Pets {
        Pet[] petList = [];
        io:println('limit);
        boolean isEqual = 'limit == 12;
        if isEqual {
            Pet pet1 = {
                id: 1,
                name: "Tommy",
                tag: "Dog"
            };
            Pet pet2 = {
                id: 2,
                name: "Rova",
                tag: "Dog"
            };
            Pet pet3 = {
                id: 3,
                name: "Tom",
                tag: "Cat"
            };
            Pet pet4 = {
                id: 4,
                name: "Jerry",
                tag: "Mouse"
            };
            petList = [pet1, pet2, pet3, pet4];

        }
        Pets pets = {petslist: petList};
        return pets;
    }

    resource function post pets() returns string {
        return "create successful";
    }

    resource function get pets/[string petId]() returns Pet|Error {
        boolean isEqual = petId == "1";
        Error err = {
            code: 1,
            message: "Pet not found"
        };

        Error|Pet output = err;
        if isEqual {
            Pet pet1 = {
                id: 1,
                name: "Tommy",
                tag: "Dog"
            };
            output = pet1;
        }

        if output is Pet {
            return <Pet>output;
        }

        return <Error>output;
    }

    //cant have client 
    resource function delete pets/[string petId]() returns http:Accepted {
        return {body: {msg: "accepted response"}};
    }

    //with request body

    resource function post pet(@http:Payload {} Pet payload) returns http:Ok {
        io:println(payload.cloneWithType(json));
        return {body: {msg: "ok response"}};

    }

    resource function get pet() returns string {
        return "tests";
    }
    //openapi_03
    resource function post user(@http:Payload {mediaType: ["application/xml", "application/json"]} User payload) returns 
    http:Ok {
        io:println(payload);
        return {body: {msg: "ok response"}};
    }
    //     resource  function  post  image(@http:Payload  {} byte[]  payload)  returns  http:Ok {
    //         io:println(payload);
    //         return {body: {msg:"ok response"}};
    // }
    //     resource  function  post  imagemulti(@http:Payload  {} json  payload)  returns  http:Ok {
    // }
    resource function get ping() returns record {| *http:NotFound; string body; |} {
        return { * http:NotFound;
        {body: {msg: "ok response"}};
        }
    }

}
