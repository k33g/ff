App.Models.User = Backbone.Model.extend({
    urlRoot:"/users"
});


App.Collections.Users = Backbone.Collection.extend({
    url:"/users",
    model:App.Models.User
});