$(function() {

    var application = new App.Views.ApplicationView({
        projects  : new App.Collections.Projects(),
        users    : new App.Collections.Users(),
        bugs      : new App.Collections.Bugs()
    });

    window.router = new App.Routers.MainRouter({application : application});

    //Backbone.history.start({pushState: true});
    Backbone.history.start();

});

