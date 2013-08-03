module models.project

import core.redis

function Project = -> DynamicObject()
	:mixin(Model())
    :kind("project")
    :db(db("localhost"))
    :keyFields(["name", "description"])
    :define("queryByName", |this, name|{
        return this: queryModels("*:name:"+name+"*")
    })



