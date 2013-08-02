module models.human

import core.models
import core.collections

function Human = ->
    DynamicObject()
        :mixin(MemoryModel("humans"))

function Humans = ->
    DynamicObject()
        :mixin(MemoryCollection("humans"))