module models.project

function Project = -> DynamicObject()
	:mixin(core.redis.Model())
    :kind("project")
    :db(core.redis.db("localhost"))
    :keyFields(["name", "description"])
    :define("queryByName", |this, name|{
        return this: queryModels("*:name:"+name+"*")
    })



