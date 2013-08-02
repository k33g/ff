module core.routes

struct router = {foo}
struct route = {url, script, method}

augment core.routes.types.router {
    function GET = |this, route| {
        return ff.routes.Router.GET(route:url(), route:script(), route:method())
    }
    function POST = |this, route| {
        return ff.routes.Router.POST(route:url(), route:script(), route:method())
    }
    function PUT = |this, route| {
        return ff.routes.Router.PUT(route:url(), route:script(), route:method())
    }
    function DELETE = |this, route| {
        return ff.routes.Router.DELETE(route:url(), route:script(), route:method())
    }
}