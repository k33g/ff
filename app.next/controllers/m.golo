module mongo

import core.json

import com.mongodb.MongoClient
import com.mongodb.MongoException
import com.mongodb.WriteConcern
import com.mongodb.DB
import com.mongodb.DBCollection
import com.mongodb.BasicDBObject
import com.mongodb.DBObject
import com.mongodb.DBCursor
import com.mongodb.ServerAddress

#TODO:
#The MongoClient instance actually represents a pool of connections to the database;
#you will only need one instance of class MongoClient even with multiple threads

function insert = |request, response| {

    let mongoClient = MongoClient("localhost", 27017)
    let db = mongoClient:getDB("mydb") # it's a DB object

    let coll = db:getCollection("testCollection") # it's a DBCollection

    #Inserting Documents

    let doc = BasicDBObject("name", "MongoDB")
        :append("type", "database")
        :append("count", 1)
        :append("info", BasicDBObject("x", 203):append("y", 102))

    coll:insert(doc)

    response:type("application/json")
    return json():stringify(doc)
}

function findone = |request, response| {

    let mongoClient = MongoClient("localhost", 27017)
    let db = mongoClient:getDB("mydb") # it's a DB object

    let coll = db:getCollection("testCollection") # it's a DBCollection

    #find first document in the collection

    let myDoc = coll:findOne() #it's a DBObject

    response:type("application/json")
    return json():stringify(myDoc)
}

function find = |request, response| {

    let mongoClient = MongoClient("localhost", 27017)
    let db = mongoClient:getDB("mydb") # it's a DB object

    let coll = db:getCollection("testCollection") # it's a DBCollection

    let query = BasicDBObject("count", 1) #object with count == 1
    let cursor = coll:find(query)

    foreach doc in cursor {
        println("--> " + doc)
    }

    cursor:each(|doc| {
        println("=> " + doc:get("_id"))
    })
    cursor:close()

    response:type("application/json")
    return json():stringify("")
}



#try {
#   while(cursor.hasNext()) {
#       System.out.println(cursor.next());
#   }
#} finally {
#   cursor.close();
#}