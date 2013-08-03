module core.collections

import ff.store.MemoryStore
import core.json

#Need DynamicObject because of mixin()
function MemoryCollection = |store| {

    # create memory store if it does'nt exist
    if MemoryStore.get(store) is null { MemoryStore.set(store, map[]) }

    let c = DynamicObject():store(store)
        :models(array[])
        :define("fetch", |this|{
            this:models(MemoryStore.get(this:store()):values():toArray())
            return this
        })
        :define("serialize", |this|{
            try {
                #println("SERIALIZE : " + ff.Parameters.appDirectory() + "/" + this:store() + ".json")
                #println("WHAT : ")
                #println(json():stringify(MemoryStore.get(this:store())))
                textToFile(json():stringify(MemoryStore.get(this:store())), ff.Parameters.appDirectory() + "/" + this:store() + ".json")
            } catch(e) {
                println("MemoryCollection:serialize : " + e:toString())
            }
        })
        :define("deSerialize",|this|{
            try {
                let text = fileToText(ff.Parameters.appDirectory() + "/" + this:store() + ".json", "UTF-8")
                MemoryStore.set(this:store(), json():toMap(text))
            } catch(e) {
                println(this:store() + ".json doesn't exist")
            }

        })
        :define("toJson", |this| {
            return json():stringify(this:models())
        })

    return c
}
