module controllers.documents

import core.json
import models.document


#GET /documents
function fetchAll = |request, response| {

    let docs = Documents():findAll()
    response:type("application/json")
    return docs:toJson()
}


#POST /documents
function create = |request, response| {
    #Inserting (a) Document(s)
    #let doc = Document():fields(json():toMap(request:body())):insert()
    let doc = Document():fromJson(request:body()):insert()

    response:type("application/json")
    return doc:toJson()
}

#PUT /documents/:_id
function save = |request, response| {
    #let id = request:params(":_id")
    let doc = Document():fromJson(request:body()):save()
    response:type("application/json")
    return doc:toJson()
}

#GET /documents/:_id
function fetch = |request, response| {
    let id = request:params(":_id")

    println("fetch : " + id)

    let doc = Document(): findById(id)

    response:type("application/json")
    return doc:toJson()
}

#DELETE /documents/:_id
function delete = |request, response| {
    let id = request:params(":_id")
    println("DELETE : " + id)
    let doc = Document(): findById(id): delete()
    response:type("application/json")
    return doc:toJson()
}