module controllers.projects

import core.json
import models.project

#GET /projects/:id
function fetch = |request, response| {
    let id = request:params(":id")
    let project = Project():setField("id",id):fetch()
    response:type("application/json")
    return project:toJson()
}

#GET /projects
function fetchAll = |request, response| {
    let projects = Projects():fetch()
    response:type("application/json")
    return projects:toJson()
}

#POST /projects
function create = |request, response| {
    let project = Project():fromJson(request:body()):save()
    response:type("application/json")
    return project:toJson()
}

#PUT /projects
function save = |request, response| {
    let project = Project():fromJson(request:body()):save()
    response:type("application/json")
    return project:toJson()
}

#DELETE /projects/:id
function delete = |request, response| {
    let id = request:params(":id")
    let project = Project():setField("id",id):setField("deleted",true):delete()
    response:type("application/json")
    return project:toJson()
}