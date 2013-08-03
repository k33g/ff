module controllers.humans

import core.json
import models.human

#GET /humans/:id
function fetch = |request, response| {
    let id = request:params(":id")
    let human = Human():setField("id",id):fetch()
    response:type("application/json")
    return human:toJson()
}

#GET /humans
function fetchAll = |request, response| {
    let humans = Humans():fetch()
    response:type("application/json")
    return humans:toJson()
}

#POST /humans
function create = |request, response| {
    let human = Human():fromJson(request:body()):save()
    response:type("application/json")
    return human:toJson()
}

#PUT /humans
function save = |request, response| {
    let human = Human():fromJson(request:body()):save()
    response:type("application/json")
    return human:toJson()
}

#DELETE /humans/:id
function delete = |request, response| {
    let id = request:params(":id")
    let human = Human():setField("id",id):setField("deleted",true):delete()
    response:type("application/json")
    return human:toJson()
}