//http://stackoverflow.com/questions/7894253/backbone-js-turning-off-wrap-by-div-in-render
App.Views.ReportProjectView = Backbone.LazyView.extend({
    tagName: 'tr',
    template : function(){/*
         <td>
             <%= project.label %>
         </td>
    */},
    initialized:function() {
        this.listenTo(this.project, 'change', this.render)
    },
    render:function() {
        this.display({project:this.project});
        return this //!!!
    }
})


App.Views.ReportView = Backbone.LazyView.extend({
    el:'report',
    template:function () {/*
    <h3><%= message %></h3>
     <table class="table table-striped table-bordered table-hover">
         <thead>
             <tr>
                 <th>Name</th>
             </tr>
         </thead>
     </table>
     */},
    initialized : function(args) {
        this.projects = args.projects;
        //this.bugs = args.bugs;
        this.listenTo(this.projects, 'sync', this.render)
    },
    render:function(){

        var selfView = this;
        this.display({message:"Reporting (work in progress)"});

        this.projects.each(function(project){
            var nestedView = new App.Views.ReportProjectView({project:project});
            selfView.$el.find("table").first().append(nestedView.render().el);

        });
    }
});
