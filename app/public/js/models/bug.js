App.Models.Bug = Backbone.Model.extend({
    urlRoot:"/bugs"
});
App.Collections.Bugs = Backbone.Collection.extend({
    url:"/bugs",
    model:App.Models.Bug
});