module controllers.bugs

import core.json
import models.bug

#GET /bugs/:id
function fetch = |request, response| {
    let id = request:params(":id")
    let bug = Bug():setField("id",id):fetch() #todo : getbyid
    response:type("application/json")
    return bug:toJson()
}

#GET /bugs
function fetchAll = |request, response| {
    let bugs = Bugs():fetch()
    response:type("application/json")
    return bugs:toJson()
}

#POST /bugs
function create = |request, response| {
    let bug = Bug():fromJson(request:body()):save()
    response:type("application/json")
    return bug:toJson()
}

#PUT /bugs
function save = |request, response| {
    let bug = Bug():fromJson(request:body()):save()
    response:type("application/json")
    return bug:toJson()
}

#DELETE /bugs/:id
function delete = |request, response| {
    let id = request:params(":id")
    let bug = Bug():setField("id",id):setField("deleted",true):delete()

    response:type("application/json")
    return bug:toJson()
}