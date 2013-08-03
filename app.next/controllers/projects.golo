module controllers.projects

import models.project

#POST /projects
function create = |request, response| {

    let project = Project(): fromJson(request:body())
    project: save()
    response:type("application/json")
    return project:toJson()
}

#PUT /projects/:id
function save = |request, response| {
    let id = request:params(":id")
    let project = Project(): fromJson(request:body())
    project: save()
    response:type("application/json")
    return project:toJson()
}

#GET /projects/:id
function fetch = |request, response| {
    let id = request:params(":id")
    println("GET : " + id)
    let project = Project(): queryById(id)
    response:type("application/json")
    return project:toJson()
}

#GET /projects
function fetchAll = |request, response| {
    println("GET : ALL")
    let projects = Project(): all(): toJsonList()
    response:type("application/json")
    return projects
}

#DELETE /projects/:id
function delete = |request, response| {
    let id = request:params(":id")
    println("DELETE : " + id)
    let project = Project(): queryById(id)
    #let project = Project(): fields(map[["id",id],["deleted", true]])
    project: delete()
    response:type("application/json")
    return project:toJson()
}