//pattern application view §3.2.2
App.Views.ApplicationView = Backbone.View.extend({
    initialize : function(args) {

        //Set properties of the application view
        this.projects = args.projects;
        this.users = args.users;
        this.bugs = args.bugs;

        this.projectsView = new App.Views.ProjectsView({collection:this.projects});
        this.projectForm = new App.Views.ProjectForm({model:new App.Models.Project()});
        //this.projectForm.model.set("label","NEW PROJECT"); //trigger render of projectForm
        this.projectForm.render()
        this.projects.fetch();

        this.usersView = new App.Views.UsersView({collection:this.users});
        this.userForm = new App.Views.UserForm({model:new App.Models.User()});
        //this.userForm.model.set({firstName:"John", lastName:"Doe"});
        this.userForm.render()
        this.users.fetch();

        this.bugsView = new App.Views.BugsView({collection:this.bugs});
        this.bugForm = new App.Views.BugForm({
            model:new App.Models.Bug(),
            projects: this.projects,
            users: this.users
        });
        //this.bugForm.model.set({label:"Bug label", description:"Bug description"});
        this.bugForm.render()
        this.bugs.fetch()

        this.reportView = new App.Views.ReportView({
            projects : this.projects,
            bugs : this.bugs
        })
        this.reportView.render()

        this.listenTo(this.projectForm, 'newproject', this.update)
        this.listenTo(this.userForm, 'newuser', this.update)
        this.listenTo(this.bugForm, 'newbug', this.update)
    },
    update : function() {
        this.projects.fetch();
        this.users.fetch();
        this.bugs.fetch()
    },
    deleteProject : function(projectId) {

        this.projects.get(projectId).destroy({
            success:function(data, response){
                console.log("project deleted", data, response)
            }
        })
    },
    deleteUser : function(userId) {

        this.users.get(userId).destroy({
            success:function(data, response){
                console.log("user deleted", data, response)
            }
        })
    },
    deleteBug : function(bugId) {

        this.bugs.get(bugId).destroy({
            success:function(data, response){
                console.log("bug deleted", data, response)
            }
        })
    }
});