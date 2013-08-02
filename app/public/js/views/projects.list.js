//J'utilise underscore pour les templates comme ça pas besoin de vue imbriquées

App.Views.ProjectsView = Backbone.LazyView.extend({
    el:'projectsList',
    template:function () {/*
         <table class="table table-striped table-bordered table-hover">
             <thead>
                 <tr>
                     <th>Name</th>
                     <th>Action</th>
                 </tr>
             </thead>
         <% _.each(projects, function(project){ %>
             <tr>
                 <td><%= project.label %></td>
                 <td><a href="#deleteproject/<%= project.id %>">Delete</a></td>
             </tr>
         <%});%>
         </table>
     */},
    initialized : function() {
        this.listenTo(this.collection, 'all', this.render)
    },
    render:function(){
        this.display({projects:this.collection});
    }
});

