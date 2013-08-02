



$(function() {

    window.models = {
        hello_world : new Golo.Code({id:"01.hello_world"}),
        functions : new Golo.Code({id:"02.functions"}),
        main : new Golo.Code({id:"03.main"}),
        import : new Golo.Import({id:"03.import"})
    }

    models.hello_world.fetch({
        success:function() {new Golo.Editor({el:"#hello_world", model:models.hello_world}).render() }
    })

    models.functions.fetch({
        success:function() {new Golo.Editor({el:"#functions", model:models.functions}).render() }
    })

    models.main.fetch({
        success:function() {new Golo.Editor({el:"#main", model:models.main}).render() }
    })

    models.import.fetch({
        success:function() {
            models.main.listenTo(models.import,"sync",function(){models.main.set("import", models.import.get("code"))})
            new Golo.SimpleEditor({el:"#import", model:models.import}).render()
        }
    })


    //ex3.set("import", ex4.get("code"))


});