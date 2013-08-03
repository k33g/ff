//J'utilise underscore pour les templates comme ça pas besoin de vue imbriquées

App.Views.ProjectsView = Backbone.LazyView.extend({
    el:'projectsList',
    template:function () {/*
     <table class="table table-striped table-bordered table-hover">
         <thead>
             <tr>
                 <th>Id</th>
                 <th>Name</th>
                 <th>Description</th>
                 <th>Action</th>
             </tr>
         </thead>
         <% _.each(projects, function(project){ %>
             <tr>
                 <td><%= project.id %></td>
                 <td><%= project.name %></td>
                 <td><%= project.description %></td>
                 <td><a href="#<%= project.id %>">Delete</a></td>
             </tr>
         <%});%>
     </table>
     */},
    initialized : function() {
        this.listenTo(this.collection, 'all', this.render)
    },
    render:function(){
        this.display({projects:this.collection});
    },
    events : {
        "click a":function(e) {//no need of router

            this.collection.get(this.getHashValue(e)).destroy({
                success:function(data, response){
                    console.log("project deleted", data, response)
                }
            })
        }
    }
});

