module routes

import core.routes
import core.stores

import core.plugins

function routes = |arg| {
    println("=== CREATING ROUTES ===")

    # This is a test
    println("by %s":format(memory():load("author")))
    #memory():delete("author")

    #-----------------------------------------
    # projects routes
    #-----------------------------------------

    # router is an augmented structure
    # route is a structure

    # Create a project
    router():POST(route()
        :url("/projects")
        :script("/controllers/projects.golo")
        :method("create")
    )

    # update one project by id
    router():PUT(route()
        :url("/projects/:id")
        :script("/controllers/projects.golo")
        :method("save")
    )

    # Get one project by id
    router():GET(route()
        :url("/projects/:id")
        :script("/controllers/projects.golo")
        :method("fetch")
    )

    # Get All projects
    router():GET(route()
        :url("/projects")
        :script("/controllers/projects.golo")
        :method("fetchAll")
    )

    # delete one project by id
    router():DELETE(route()
        :url("/projects/:id")
        :script("/controllers/projects.golo")
        :method("delete")
    )

    #-----------------------------------------
    # users routes
    #-----------------------------------------
    router():POST(route():url("/users"):script("/controllers/users.golo"):method("create"))
    router():PUT(route():url("/users/:id"):script("/controllers/users.golo"):method("save"))
    router():GET(route():url("/users/:id"):script("/controllers/users.golo"):method("fetch"))
    router():GET(route():url("/users"):script("/controllers/users.golo"):method("fetchAll"))
    router():DELETE(route():url("/users/:id"):script("/controllers/users.golo"):method("delete"))

    #-----------------------------------------
    # bugs routes
    #-----------------------------------------
    router():POST(route():url("/bugs"):script("/controllers/bugs.golo"):method("create"))
    router():PUT(route():url("/bugs/:id"):script("/controllers/bugs.golo"):method("save"))
    router():GET(route():url("/bugs/:id"):script("/controllers/bugs.golo"):method("fetch"))
    router():GET(route():url("/bugs"):script("/controllers/bugs.golo"):method("fetchAll"))
    router():DELETE(route():url("/bugs/:id"):script("/controllers/bugs.golo"):method("delete"))

    #-----------------------------------------
    # reload  routes
    #-----------------------------------------
    #DEVELOPER MODE : reload all golo scripts
    router():GET(route():url("/reload"):script("/core/helpers.golo"):method("reload"))


    #-----------------------------------------
    # humans routes
    #-----------------------------------------
    router():POST(route():url("/humans"):script("/controllers/humans.golo"):method("create"))
    router():PUT(route():url("/humans/:id"):script("/controllers/humans.golo"):method("save"))
    router():GET(route():url("/humans/:id"):script("/controllers/humans.golo"):method("fetch"))
    router():GET(route():url("/humans"):script("/controllers/humans.golo"):method("fetchAll"))
    router():DELETE(route():url("/humans/:id"):script("/controllers/humans.golo"):method("delete"))


    println("=== END OF ROUTES ===")
}