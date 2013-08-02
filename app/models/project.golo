module models.project

import core.models
import core.collections

function Project = ->
    DynamicObject()
        :mixin(MemoryModel("projects"))

function Projects = ->
    DynamicObject()
        :mixin(MemoryCollection("projects"))


