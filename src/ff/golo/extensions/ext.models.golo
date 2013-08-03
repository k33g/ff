module core.models

import core.json

import java.util.UUID
import ff.store.MemoryStore

#Need DynamicObject because of mixin()
function MemoryModel = |store| {

    # create memory store if it does'nt exist
    if MemoryStore.get(store) is null { MemoryStore.set(store, map[]) }

    let m = DynamicObject():store(store)
        :fields(map[])
        :define("setAllFields", |this, hm| {
            this:fields(hm)
            return this
        })
        :define("getField", |this, fieldName| {
            return this:fields():get(fieldName)
        })
        :define("setField", |this, fieldName, value| {
            this:fields():put(fieldName, value)
            return this
        })
        :define("uuid", |this|-> UUID.randomUUID():toString())
        :define("fetch", |this|{
            this:fields(
                MemoryStore.get(this:store())
                    :get(
                        this:getField("id")
                        )
            )
            return this
        })
        :define("save", |this|{ #TODO:callback
            if this:fields():get("id") is null { #create
                #println("SAVE MODEL:CREATE")
                this:fields():put("id", this:uuid())
                MemoryStore.get(this:store()):add(this:fields():get("id"), this:fields())
            } else { #update
                #println("SAVE MODEL:UPDATE")
                MemoryStore.get(this:store()):add(this:fields():get("id"), this:fields())
            }
            return this
        })
        :define("delete", |this|{
            MemoryStore.get(this:store()):remove(this:getField("id"))
            return this
        })
        :define("toJson", |this| -> json():stringify(this:fields()))
        :define("fromJson", |this, body| {
            this:fields(json():toMap(body))
            return this
        })

    return m
}
