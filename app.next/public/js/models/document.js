App.Models.Document = Backbone.Model.extend({
    idAttribute: "_id",
    urlRoot:"/documents"
});
App.Collections.Documents = Backbone.Collection.extend({
    url:"/documents",
    model:App.Models.Document
});
