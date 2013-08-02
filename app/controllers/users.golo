module controllers.users

import core.json
import models.user

#GET /users/:id
function fetch = |request, response| {
    let id = request:params(":id")
    let user = User():setField("id",id):fetch()

    response:type("application/json")
    return json():stringify(user:fields())
}

#GET /users
function fetchAll = |request, response| {

    let users = Users():fetch():models()

    response:type("application/json")
    return json():stringify(users)
}

#POST /users
function create = |request, response| {
    let fields = json():toMap(request:body())
    let user = User():setAllFields(fields):save()

    response:type("application/json")
    return json():stringify(user:fields())
}

#PUT /users
function save = |request, response| {
    let fields = json():toMap(request:body())
    let user = User():setAllFields(fields):save()

    response:type("application/json")
    return json():stringify(user:fields())
}

#DELETE /users/:id
function delete = |request, response| {
    let id = request:params(":id")
    let user = User():setField("id",id):setField("deleted",true):delete()

    response:type("application/json")
    return json():stringify(user:fields())
}