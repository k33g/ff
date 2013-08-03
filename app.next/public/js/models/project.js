App.Models.Project = Backbone.Model.extend({
    urlRoot:"/projects"
});
App.Collections.Projects = Backbone.Collection.extend({
    url:"/projects",
    model:App.Models.Project
});

