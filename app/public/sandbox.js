
window.Dog = Backbone.Model.extend({
    defaults : {
        name : "wolf"
    }
    //initialize : function Dog() {}
});

window.Child = Backbone.Model.extend({
    defaults: {
        firstName:"Johnny", lastName:"Doe"
    }
});

window.Children = Backbone.Collection.extend({
    model:Child
});

window.Human = Backbone.Model.extend({
    urlRoot:"/humans",
    defaults: {
        firstName:"John", lastName:"Doe",
        dog: new Dog(),
        children : new Children([new Child()])
    },
    initialize : function() {
        this.listenTo(this, "sync", this.deserialize)
    },
    deserialize : function() {
        this.set("dog",new Dog(this.get("dog")));
        this.set("children",new Children(this.get("children")));
    }
});

window.Humans = Backbone.Collection.extend({
    url:"/humans",
    model:Human
});