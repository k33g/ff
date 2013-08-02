module controllers.projects

import core.json
import models.project

#GET /projects/:id
function fetch = |request, response| {
    let id = request:params(":id")
    let project = Project():setField("id",id):fetch()

    response:type("application/json")
    return json():stringify(project:fields())
}

#GET /projects
function fetchAll = |request, response| {
    let projects = Projects():fetch():models()

    response:type("application/json")
    return json():stringify(projects)
}

#POST /projects
function create = |request, response| {
    let fields = json():toMap(request:body())
    let project = Project():setAllFields(fields):save()

    response:type("application/json")
    return json():stringify(project:fields())
}

#PUT /projects
function save = |request, response| {
    let fields = json():toMap(request:body())
    let project = Project():setAllFields(fields):save()

    response:type("application/json")
    return json():stringify(project:fields())
}

#DELETE /projects/:id
function delete = |request, response| {
    let id = request:params(":id")
    let project = Project():setField("id",id):setField("deleted",true):delete()

    response:type("application/json")
    return json():stringify(project:fields())
}