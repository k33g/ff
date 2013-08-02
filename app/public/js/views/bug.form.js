
App.Views.BugForm = Backbone.LazyView.extend({
    el:"bugForm",
    template:function(){/*
        <div class="panel">
            <div class="panel-heading">New Bug ...</div>
            <div class="form-inline">
                 <input style="width:20%;" class="form-control" placeholder="Bug Label" type="text" value="<%= bug.label %>"/>
                 <input style="width:20%;" class="form-control" placeholder="Bug Description" type="text" value="<%= bug.description %>"/>
                 <span style="width:5%;">Project : </span>
                 <select style="width:15%;" class="form-control"><% _.each(projects, function(project){ %>
                     <option value="<%= project.id %>"><%= project.label %></option>
                 <%});%> </select>
                 <span style="width:5%;">User : </span>
                 <select style="width:15%;" class="form-control"><% _.each(users, function(user){ %>
                    <option value="<%= user.id %>"><%= user.nickName %></option>
                 <%});%> </select>
                 <button style="width:10%;" class="btn btn-primary">Add</button>
            </div>
        </div>
     */},
    initialized : function() {

        this.listenTo(this.model, 'change', this.render)

        /*No nested view -> render all view*/
        this.listenTo(this.projects, 'all', this.render)
        this.listenTo(this.users, 'all', this.render)

    },
    render : function(){
        this.display({
            bug:this.model,
            projects:this.projects,
            users:this.users
        })
    },
    events:{
        "change":function(e){
            console.log(e)
        },
        "click button":function(e) {
            var selfView = this;

            this.model.set({
                label : this.getValue("input:eq(0)"), //selfView.$el.find("input").first().val(),
                description : this.getValue("input:eq(1)"),
                project : this.getText("select:eq(0) option:selected"),
                user : this.getText("select:eq(1) option:selected")
            });

            this.model.clone().save({},{success:function(){
                selfView.trigger('newbug')
                selfView.model.clear()
            }})
        }
    }
})