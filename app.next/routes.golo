module routes

import core.routes
import core.stores

import core.plugins

function routes = |arg| {
    println("=== CREATING ROUTES ===")

    # Get All documents
    router():GET(route()
        :url("/documents")
        :script("/controllers/documents.golo")
        :method("fetchAll")
    )
    # Create a document
    router():POST(route()
        :url("/documents")
        :script("/controllers/documents.golo")
        :method("create")
    )
    # update one document (by id ?)
    router():PUT(route()
        :url("/documents/:_id")
        :script("/controllers/documents.golo")
        :method("save")
    )
    # Get one document by id
    router():GET(route()
        :url("/documents/:_id")
        :script("/controllers/documents.golo")
        :method("fetch")
    )

    # delete one document by id
    router():DELETE(route()
        :url("/documents/:_id")
        :script("/controllers/documents.golo")
        :method("delete")
    )

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
    # reload  routes
    #-----------------------------------------
    #DEVELOPER MODE : reload all golo scripts
    router():GET(route():url("/reload"):script("/core/helpers.golo"):method("reload"))


    println("=== END OF ROUTES ===")
}