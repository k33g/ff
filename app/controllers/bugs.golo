module controllers.bugs

import core.json
import models.bug

#GET /bugs/:id
function fetch = |request, response| {
    let id = request:params(":id")
    let bug = Bug():setField("id",id):fetch()

    response:type("application/json")
    return json():stringify(bug:fields())
}

#GET /bugs
function fetchAll = |request, response| {
    let bugs = Bugs():fetch():models()

    response:type("application/json")
    return json():stringify(bugs)
}

#POST /bugs
function create = |request, response| {
    let fields = json():toMap(request:body())
    let bug = Bug():setAllFields(fields):save()

    response:type("application/json")
    return json():stringify(bug:fields())
}

#PUT /bugs
function save = |request, response| {
    let fields = json():toMap(request:body())
    let bug = Bug():setAllFields(fields):save()

    response:type("application/json")
    return json():stringify(bug:fields())
}

#DELETE /bugs/:id
function delete = |request, response| {
    let id = request:params(":id")
    let bug = Bug():setField("id",id):setField("deleted",true):delete()

    response:type("application/json")
    return json():stringify(bug:fields())
}