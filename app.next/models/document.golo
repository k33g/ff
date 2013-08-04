module models.document

import core.mongo

function Document = -> DynamicObject()
    :mixin(core.mongo.Model())
    :db("localhost", 27017, "mydb")
    :mongoCollection("testCollection")
    :define("getTitle", |this| {
        return this:getField("title")
    })
    :define("getAuthor", |this| {
        return this:getField("author")
    })

function Documents = -> DynamicObject()
    :mixin(core.mongo.Collection())
    :db("localhost", 27017, "mydb")
    :mongoCollection("testCollection")
    :model(Document())