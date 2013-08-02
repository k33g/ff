App.Views.ProjectForm = Backbone.LazyView.extend({
    el:"projectForm",
    template:function(){/*
     <div class="panel">
         <div class="panel-heading">New Project ...</div>
         <div class="form-inline">
            <input style="width:40%;" class="form-control" placeholder="Project Name" type="text" value="<%= project.label %>"/>
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

            this.model.set({label : this.getValue("input:eq(0)")})

            this.model.clone().save({},{success:function(){
                selfView.trigger('newproject');
                selfView.model.clear();
            }})
        }
    }
});
