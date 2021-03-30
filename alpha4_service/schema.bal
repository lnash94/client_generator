public type Pet record {
    int id;
    string name;
    string tag?;
};

public type Pets record {
    Pet[] petslist;
};

public type  Error record  { 
    int  code;
    string  message;
};

public type User record {
    int id;
    string name?;
};