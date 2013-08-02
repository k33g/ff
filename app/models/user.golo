module models.user

import core.models
import core.collections

function User = ->
    DynamicObject()
        :mixin(MemoryModel("users"))

function Users = ->
    DynamicObject()
        :mixin(MemoryCollection("users"))