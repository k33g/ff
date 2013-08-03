//pattern application view §3.2.2
App.Views.ApplicationView = Backbone.View.extend({
    initialize : function(args) {

        //Set properties of the application view
        this.projects = args.projects;

        this.projectsView = new App.Views.ProjectsView({collection:this.projects});
        this.projectForm = new App.Views.ProjectForm({model:new App.Models.Project()});
        //this.projectForm.model.set("label","NEW PROJECT"); //trigger render of projectForm
        this.projectForm.render()
        this.projects.fetch();

        this.listenTo(this.projectForm, 'newproject', this.update)

    },
    update : function() {
        this.projects.fetch();
    },
    deleteProject : function(projectId) {

        this.projects.get(projectId).destroy({
            success:function(data, response){
                console.log("project deleted", data, response)
            }
        })
    }

});