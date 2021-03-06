module routes

import core.routes
import core.stores

import core.plugins

function routes = |arg| {
    println("=== CREATING ROUTES ===")

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



    #-----------------------------------------
    # reload  routes
    #-----------------------------------------
    #DEVELOPER MODE : reload all golo scripts
    router():GET(route():url("/reload"):script("/core/helpers.golo"):method("reload"))


    println("=== END OF ROUTES ===")
}