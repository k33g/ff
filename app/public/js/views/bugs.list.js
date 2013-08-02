//J'utilise underscore pour les templates comme ça pas besoin de vue imbriquées

App.Views.BugsView = Backbone.LazyView.extend({
    el:'bugsList',

    template:function () {/*
        <table class="table table-striped table-bordered table-hover">
             <thead>
                 <tr>
                     <th>Project/User</th>
                     <th>Label</th>
                     <th>Description</th>
                     <th>Action</th>
                 </tr>
             </thead>
        <% _.each(bugs, function(bug){ %>
            <tr>
                <td>[<%= bug.project %>][<%= bug.user %>]</td>
                <td><%= bug.label %></td>
                <td><%= bug.description %></td>
                <!--<td><a href="#deletebug/<%= bug.id %>">Delete when done</a></td>-->
                <td>
                    <a href="#<%= bug.id %>">Delete when done</a>
                    <button data-label="<%= bug.label %>" data-value="<%= bug.id %>" class="btn btn-mini btn-primary">Informations</button>
                </td>
            </tr>
        <%});%>
        </table>
    */},
    initialized : function() {
        this.listenTo(this.collection, 'all', this.render)
    },
    render:function(){
        this.display({bugs:this.collection});
    },
    events:{
        "click a":function(e) {
            this.collection.get(this.getHashValue(e)).destroy({
                success:function(data, response){
                    console.log("bug deleted", data, response)
                }
            })
        },
        "click button":function(e) {
            console.log(this.getDataValue(e), this.getData("label", e))
        }
    }


});
