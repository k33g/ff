module core.mongo

import core.json
import core.stores

import com.mongodb.MongoClient
import com.mongodb.MongoException
import com.mongodb.WriteConcern
import com.mongodb.DB
import com.mongodb.DBCollection
import com.mongodb.BasicDBObject
import com.mongodb.DBObject
import com.mongodb.DBCursor
import com.mongodb.ServerAddress
import org.bson.types.ObjectId


function db = |host, port, dbname| {

    let mongoDatabase = memory():load(host + port + dbname)
    #The MongoClient instance actually represents a pool of connections to the database;
    #you will only need one instance of class MongoClient even with multiple threads
    if mongoDatabase isnt null {
        println("mongoDatabase client already loaded :)")
        return mongoDatabase
    } else {
        let mongoClient = MongoClient(host, port)
        let db = mongoClient:getDB(dbname)          # it's a DB object
        memory():save(host + port + dbname, db)
        return db
    }
}


function Model = {
    let m = DynamicObject()
        :define("db", |this, host, port, dbname| {
            this:_db(db(host, port, dbname))
            return this
        })
        :define("mongoCollection", |this, collectionName| {
            let collection = this:_db():getCollection(collectionName) # it's a DBCollection
            this:_mongoCollection(collection)
            return this
        })
        :define("fields", |this, fieldsMap| {
            println("fieldsMap : "+ fieldsMap)
            let bdbo = BasicDBObject(fieldsMap)
            this:DBObject(bdbo)            #basicDBObject

            println("JSON : " + this:DBObject():toString())

            return this
        })
        :define("fromJson", |this, body| {
            this:fields(json():toMap(body))
            return this
        })
        :define("getId", |this| {
            let id = this:DBObject():get("_id")
            if id isnt null { return id:toString() } else { return null }
        })
        :define("getObjectId", |this| {
            return this:DBObject():get("_id")
        })
        :define("getField", |this, fieldName| { return this:DBObject():get(fieldName) })
        :define("setField", |this, fieldName, value| {
            this:DBObject():put(fieldName, value)
            return this
        })
        :define("toJson", |this| {
            #this:DBObject()
            let m = this:DBObject():clone()
            if this:getId() isnt null { m:put("_id", this:getId()) }
            return m:toString()
        })
        :define("insert", |this| { #TODO: add callback / optional parameter

            this:_mongoCollection():insert(this:DBObject())
            #if callback isnt null {
            #    println("--- callback after insert ---")
            #    callback(this)
            #}
            return this
        })
        :define("findOne", |this| { #findOne :
            this:DBObject(this:_mongoCollection():findOne()) #it's a DBObject vs basicDBObject ?
            return this
        })
        :define("find", |this, fieldName, value | { #very simple query ability
            println("1- find fieldName, value : " + fieldName + " = " + value)
            let query = BasicDBObject(fieldName, value)
            #this:DBObject(this:_mongoCollection():findOne(query))
            #this:DBObject() # strange behaviour, if not can't do getField
            println("2- find query : " + query)
            let cursor = this:_mongoCollection():find(query)
            let model = cursor:iterator(): next()
            println("3- find model : " + model)
            this:DBObject(model)
            cursor:close()

            return this
        })
        :define("findByQuery", |this, query | {
            #TODO : create struct (augment) or DynamicObject for query
            #TODO : only one find() ?
        })
        :define("findById", |this, id| {
            println("1- findById id : " + id)
            let query = BasicDBObject()
            query: put("_id", ObjectId(id))
            println("2- findById query : " + query)
            #let model = this:_mongoCollection():findOne(query)
            #println("3- findById model : " + model)
            #this:DBObject(model)
            #println(this:DBObject()) # strange behaviour, if not can't do getField
            let cursor = this:_mongoCollection():find(query)
            let model = cursor:iterator(): next()
            println("3- findById model : " + model)
            this:DBObject(model)
            cursor:close()

            return this
        })
        :define("save", |this| {
            this:_mongoCollection():save(this:DBObject())
            return this
        })
        :define("delete", |this| {
            println(this:DBObject())
            this:_mongoCollection():remove(this:DBObject())
            return this
        })
    return m
}

function Collection = {
    let c = DynamicObject()
        :models(list[])
        :define("db", |this, host, port, dbname| {
            this:_db(db(host, port, dbname))
            return this
        })
        :define("mongoCollection", |this, collectionName| {
            let collection = this:_db():getCollection(collectionName) # it's a DBCollection
            this:_mongoCollection(collection)
            return this
        })
        :define("findAll", |this| {
            let cursor = this:_mongoCollection():find()
            cursor:each(|doc| {
                this:models():add(this:model():copy():fields(doc))
                #println("=> " + doc)
            })
            cursor:close()
            return this
        })
        :define("find", |this, query | {
            #TODO : create struct (augment and use BasicDBObject) or DynamicObject for query
            #TODO : struct query = {}
            #TODO : or only create a function query()that return BasicDBObject
            #TODO : query():add():add() ...
        })
        :define("toJson", |this| {
            let models = list[]
            this:models():each(|model| {
                let h = json():toMap(model:toJson())
                models:add(h)
            })
            return json():stringify(models)
        })
    return c
}
