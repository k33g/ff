App.Views.ProjectForm = Backbone.LazyView.extend({
    el:"projectForm",
    template:function(){/*
     <div class="panel">
     <div class="panel-heading">New Project ... (Redis Demo)</div>
     <div class="form-inline">
     <input style="width:40%;" class="form-control" placeholder="Project Name" type="text" value="<%= project.name %>"/>
     <input style="width:40%;" class="form-control" placeholder="Project Description" type="text" value="<%= project.description %>"/>
     <button style="width:10%;" class="btn btn-primary">Add</button>
     </div>
     </div>
     */},
    initialized : function() {
        this.listenTo(this.model, 'change', this.render)
    },
    render : function(e){
        this.display({project:this.model});
    },
    events:{
        "change":function(e){
            console.log(e)
        },
        "click button":function(e) {
            var selfView = this;

            console.log(this.getValue("input:eq(0)"),this.getValue("input:eq(1)"))

            this.model.set({
                name : selfView.getValue("input:eq(0)"),
                description : selfView.getValue("input:eq(1)")
            })

            this.model.clone().save({},{success:function(){
                selfView.trigger('newproject');
                selfView.model.clear();
            }})
        }
    }
});
