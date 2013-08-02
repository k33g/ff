module golocode

import ff.json.Json
import java.util.HashMap

#PUT /golocodes
function run = |request, response| {

    #println(request:body())

    let scriptName = request:params(":id")
    #println("-->"+scriptName)

    let jsonNode = Json.parse(request:body())

    let data = Json.fromJson(jsonNode, HashMap.class)

    textToFile(data:get("code"),"goloprez/codes/" + scriptName + ".gologolo")

    #println("main code : " + data:get("code"))

    #println("code to be imported : " + data:get("import"))

    #set id ?

    let evalEnv = gololang.EvaluationEnvironment()


    #evalEnv:imports("ff.golo.tools.console") -> vérifier si cela fonctionne pour les plugins (sinon utiliser mon code pourri de compilation)
    #evalEnv:imports("hello.hi")


    let importedCode = data:get("import")
    if importedCode isnt null {
        evalEnv: asModule(importedCode)
    }

    let mod = evalEnv:asModule(data:get("code"))
    let f = fun("main",mod)
    let r = f(null)

    data:put("result",console.buffer())

    console.empty()

    response:type("application/json")
    return Json.stringify(Json.toJson(data))

}

#Save import
function save = |request, response| {

    let scriptName = request:params(":id")
    let jsonNode = Json.parse(request:body())
    let data = Json.fromJson(jsonNode, HashMap.class)
    textToFile(data:get("code"),"goloprez/codes/" + scriptName + ".gologolo")
    response:type("application/json")
    return Json.stringify(Json.toJson(data))

}


#GET /golocodes/:id
function load = |request, response| {

    let scriptName = request:params(":id") #route : /golocodes/:id
    let text = fileToText("goloprez/codes/" + scriptName + ".gologolo", "UTF-8")
    let data = HashMap()
    data:put("code", text)
    response:type("application/json")
    return Json.stringify(Json.toJson(data))

}
