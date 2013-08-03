module core.json

struct json = {foo}

augment core.json.types.json {
    function toMap = |this, something|-> ff.json.Json.fromJson(ff.json.Json.parse(something), java.util.HashMap.class)
    #because i can't override toString()
    function stringify = |this, something|-> ff.json.Json.stringify(ff.json.Json.toJson(something))

    function toJson = |this, something|-> ff.json.Json.toJson(something)

    function fromJson = |this, something, klass| -> ff.json.Json.fromJson(something, klass)

    function parse = |this, something| ->ff.json.Json.parse(something)
}


#function JSON = ->
#    DynamicObject()
#        :toMap(
#            |this, something|->
#                ff.json.Json.fromJson(ff.json.Json.parse(something), java.util.HashMap.class)
#        )
#        :toString(
#            |this, something|->
#                ff.json.Json.stringify(ff.json.Json.toJson(something))
#        )