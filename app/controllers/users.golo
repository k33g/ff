module controllers.users

import core.json
import models.user

#GET /users/:id
function fetch = |request, response| {
    let id = request:params(":id")
    let user = User():setField("id",id):fetch()
    response:type("application/json")
    return user:toJson()
}

#GET /users
function fetchAll = |request, response| {
    let users = Users():fetch()
    response:type("application/json")
    return users:toJson()
}

#POST /users
function create = |request, response| {
    let user = User():fromJson(request:body()):save()
    response:type("application/json")
    return user:toJson()
}

#PUT /users
function save = |request, response| {
    let user = User():fromJson(request:body()):save()
    response:type("application/json")
    return user:toJson()
}

#DELETE /users/:id
function delete = |request, response| {
    let id = request:params(":id")
    let user = User():setField("id",id):setField("deleted",true):delete()
    response:type("application/json")
    return user:toJson()
}