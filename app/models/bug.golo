module models.bug

import core.models
import core.collections

function Bug = ->
    DynamicObject()
        :mixin(MemoryModel("bugs"))

function Bugs = ->
    DynamicObject()
        :mixin(MemoryCollection("bugs"))