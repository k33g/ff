App.Routers.MainRouter = Backbone.Router.extend({
    initialize : function(args){
        this.application = args.application
        if (!this.application) throw 'Requires an application instance'
    },
    routes : {
        "deleteproject/:id" : "deleteProject"

    },
    deleteProject : function (id) {
        this.application.deleteProject(id)
    }

});