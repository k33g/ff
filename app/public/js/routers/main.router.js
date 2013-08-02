App.Routers.MainRouter = Backbone.Router.extend({
    initialize : function(args){
        this.application = args.application
        if (!this.application) throw 'Requires an application instance'
    },
    routes : {
        "deleteproject/:id" : "deleteProject",
        "deleteuser/:id" : "deleteUser",
        "deletebug/:id" : "deleteBug"

    },
    deleteProject : function (id) {
        this.application.deleteProject(id)
    },
    deleteUser : function (id) {
        this.application.deleteUser(id)
    },
    deleteBug : function (id) {
        this.application.deleteBug(id)
    }

});