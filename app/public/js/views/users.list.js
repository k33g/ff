//J'utilise underscore pour les templates comme ça pas besoin de vue imbriquées

App.Views.UsersView = Backbone.LazyView.extend({
    el:'usersList',
    template:function () {/*
         <table class="table table-striped table-bordered table-hover">
             <thead>
                 <tr>
                     <th>NickName</th>
                     <th>FirstName</th>
                     <th>LastName</th>
                     <th>Action</th>
                 </tr>
             </thead>
             <% _.each(users, function(user){ %>
             <tr>
                 <td><%= user.nickName %></td>
                 <td><%= user.firstName %></td>
                 <td><%= user.lastName %></td>
                 <td><a href="#deleteuser/<%= user.id %>">Delete</a></td>
             </tr>
             <%});%>
         </table>
    */},
    initialized : function() {
        this.listenTo(this.collection, 'all', this.render)
    },
    render:function(){
        this.display({users:this.collection.toJSON()});
    }
});

