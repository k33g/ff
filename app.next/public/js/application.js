$(function() {

    window.application = new App.Views.ApplicationView({
        projects  : new App.Collections.Projects()
    });

    window.router = new App.Routers.MainRouter({application : application});

    //Backbone.history.start({pushState: true});
    Backbone.history.start();

});

