module core.redis

import core.json
import java.util.HashMap
import java.util.UUID
import redis.clients.jedis.Jedis

function db = |host| -> Jedis(host)

function Model = -> DynamicObject()
    :kind("something")
    :fields(map[])
    :define("toJson", |this| -> json():stringify(this:fields()))
    :define("fromJson", |this, body| {
        this:fields(json():toMap(body))
        return this
    })
    :define("getField", |this, fieldName| -> this: fields(): get(fieldName))
    :define("setField", |this, fieldName, value| {
        this: fields(): put(fieldName, value)
        return this
    })
    :define("getKeyById", |this| {
        var keyToDelete = null
        try {
            #Search by id to get the exact key
            let allKeys = this: db(): keys(this: kind()+"*id:"+this: fields(): get("id")+"*")
            if allKeys: size() > 0 {
                keyToDelete = allKeys: iterator(): next()
            }
        } catch(e) {
            println("Huston we've got a problem when getting exact key by id")
        } finally {
            return keyToDelete
        }
    })
    :define("delete", |this| {
        try {
            #Search by id to get the exact key
            let exactKeyToDelete = this: getKeyById()
            if exactKeyToDelete isnt null {
                this: db(): del(exactKeyToDelete)
            } else {
                println("nothing to delete")
            }

        } catch(e) {
            println("Huston we've got a problem when deleting model")
        }

        return this
    })
    :define("save", |this| {
        #keyfields : Array, fields to construct the key
        let values = map[["result", ""]]

        this: keyFields():each(|key| {
            values:put("result", values:get("result") + key + ":" + this: getField(key) + ":")
        })

        #verifiy if id exists
        var id = this: fields(): get("id")

        if id is null { #creation
            id = UUID.randomUUID()
            this: fields(): put("id", id)
        } else { #update
            try {
                this: db(): del(this: getKeyById())
            } catch(e) {
                e: printStackTrace()
            }
        }

        let key = this: kind()+":"+values:get("result")+"id:"+id
        #this: key(key) #useful ? ... We'll see

        try {
            let stringToSave = json():stringify(this: fields())
            this: db(): set(key, stringToSave)
        } catch(e) {
            println(e: getCause(): getMessage())
            println("Huston we've got a problem when saving model")
        }
        return this
    })
    :define("all",|this| {
        this: modelsList(list[])
        this: allKeys(this: db(): keys(this: kind()+":*"))
        return this
    })
    :define("query", |this, queryString|{
        this: modelsList(list[])
        this: allKeys(this: db(): keys(this: kind()+queryString))
        return this
    })
    :define("toJsonList",|this| {
        # :all():toJson()
        this: allKeys():each(|key| {
            let modelJsonNode =  json():parse(this: db(): get(key))
            let modelHashMap = json():fromJson(modelJsonNode, HashMap.class)
            this: modelsList(): add(modelHashMap)
        })
        return json():stringify(this: modelsList())
    })
    :define("models",|this| {
        # :all():models()
        this: allKeys():each(|key| {
            let modelJsonNode =  json():parse(this: db(): get(key))
            let modelHashMap = json():fromJson(modelJsonNode, HashMap.class)
            let model = Model(): kind(this: kind()): fields(modelHashMap)
            this: modelsList(): add(model)
        })
        return this: modelsList()
    })
    :define("queryById", |this, id|{
        return this: query("*:id:"+id+"*"): models(): getFirst()
    })
