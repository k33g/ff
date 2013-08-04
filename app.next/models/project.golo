module models.project

import core.redis

function Project = -> DynamicObject()
	:mixin(core.redis.Model())
    :kind("project")
    :db("localhost",6379)
    :keyFields(["name", "description"])
    :define("queryByName", |this, name|{
        return this: queryModels("*:name:"+name+"*")
    })



