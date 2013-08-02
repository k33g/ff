module controllers.humans

import core.json
import models.human

#GET /humans/:id
function fetch = |request, response| {
    let id = request:params(":id")
    let human = Human():setField("id",id):fetch()

    response:type("application/json")
    return json():stringify(human:fields())
}

#GET /humans
function fetchAll = |request, response| {

    let humans = Humans():fetch():models()

    response:type("application/json")
    return json():stringify(humans)
}

#POST /humans
function create = |request, response| {

    println(request:body())


    let fields = json():toMap(request:body())

    println(fields)

    let human = Human():setAllFields(fields):save()

    response:type("application/json")
    return json():stringify(human:fields())
}

#PUT /humans
function save = |request, response| {
    let fields = json():toMap(request:body())
    let human = Human():setAllFields(fields):save()

    response:type("application/json")
    return json():stringify(human:fields())
}

#DELETE /humans/:id
function delete = |request, response| {
    let id = request:params(":id")
    let human = Human():setField("id",id):setField("deleted",true):delete()

    response:type("application/json")
    return json():stringify(human:fields())
}