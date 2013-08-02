module core.stores

import ff.store.MemoryStore

struct memory = {foo}

augment core.stores.types.memory {

    #Can't use get() because it's already a struct member
    function load = |this, key| -> MemoryStore.get(key)

    #Can't use set() because it's already a struct member
    function save = |this, key, value| -> MemoryStore.set(key, value)

    #TODO: Verify delete vd remove
    function delete = |this, key| -> MemoryStore.delete(key)
}