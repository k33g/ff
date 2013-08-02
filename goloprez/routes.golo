module routes

import core.routes

function routes = |arg| {

    # Get one project by id
    router():GET(route()
        :url("/golocodes/:id")
        :script("/controllers/golocodes.golo")
        :method("load")
    )

    router():GET(route()
        :url("/goloimports/:id")
        :script("/controllers/golocodes.golo")
        :method("load")
    )



    # update one project by id
    router():PUT(route()
        :url("/golocodes/:id")
        :script("/controllers/golocodes.golo")
        :method("run")
    )


    # update one project by id
    router():PUT(route()
        :url("/goloimports/:id")
        :script("/controllers/golocodes.golo")
        :method("save")
    )

}