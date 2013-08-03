$(function() {

    var application = new App.Views.ApplicationView({

    });

    window.router = new App.Routers.MainRouter({application : application});

    //Backbone.history.start({pushState: true});
    Backbone.history.start();

});

