App.Views.UserForm = Backbone.LazyView.extend({
    el:"userForm",
    template:function(){/*
     <div class="panel">
        <div class="panel-heading">New User ...</div>
        <div class="form-inline">
            <input style="width:20%;" class="form-control" placeholder="nickname" type="text" value="<%= user.nickName %>"/>
            <input style="width:20%;" class="form-control" placeholder="firstName" type="text" value="<%= user.firstName %>"/>
            <input style="width:20%;" class="form-control" placeholder="lastName" type="text" value="<%= user.lastName %>"/>
            <button style="width:10%;" class="btn btn-primary">Add</button>
        </div>
     </div>
     */},
    initialized : function() {
        this.listenTo(this.model, 'change', this.render)
    },
    /*
    initialize : function(args) {
        App.Views.UserForm.__super__.initialize.call(this, args);
        this.listenTo(this.model, 'change', this.render)
    },
    */
    render : function(){
        this.display({user:this.model});
    },
    events:{
        "change":function(e){
            console.log(e)
        },
        "click button":function(e) {
            var selfView = this;

            this.model.set({
                nickName : this.getValue("input:eq(0)"),
                firstName : this.getValue("input:eq(1)"),
                lastName : this.getValue("input:eq(2)")
            });

            this.model.clone().save({},{success:function(){
                selfView.trigger('newuser');
                selfView.model.clear();
            }})
        }
    }
});
