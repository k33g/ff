module models.document

import core.mongo

# This is a model
function Document = -> DynamicObject()
    :mixin(core.mongo.Model())          # inheritance
    :db("localhost", 27017, "mydb")     # mandatory
    :mongoCollection("testCollection")  # mandatory
    :define("getTitle", |this| {        # add some methods
        return this:getField("title")
    })
    :define("getAuthor", |this| {       # add some methods
        return this:getField("author")
    })

# This is a collection
function Documents = -> DynamicObject()
    :mixin(core.mongo.Collection())     # inheritance
    :db("localhost", 27017, "mydb")     # mandatory
    :mongoCollection("testCollection")  # mandatory
    :model(Document())                  # mandatory