module controllers.projects

import core.json
import models.project

#GET /projects/:id
function fetch = |request, response| {
    let id = request:params(":id")
    println(id)

    response:type("application/json")
    return json():stringify(map[])
}

#GET /projects
function fetchAll = |request, response| {

    response:type("application/json")
    return json():stringify(array[map[]])
}

#POST /projects
function create = |request, response| {
    let fields = json():toMap(request:body())
    fields:put("id",java.util.UUID.randomUUID():toString())
    println(fields)

    response:type("application/json")
    return json():stringify(fields)
}

#PUT /projects/:id
function save = |request, response| {
    let id = request:params(":id")
    let fields = json():toMap(request:body())
    println(fields)

    response:type("application/json")
    return json():stringify(fields)
}

#DELETE /projects/:id
function delete = |request, response| {
    let id = request:params(":id")
    println(id)

    response:type("application/json")
    return json():stringify(map[])
}