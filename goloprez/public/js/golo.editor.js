var Golo = {
    Code : Backbone.Model.extend({
        urlRoot:"/golocodes",
        defaults : {
            code : "# Golo is fun",
            result : ">"
        }
    }),

    Import : Backbone.Model.extend({
        urlRoot:"/goloimports",
        defaults : {
            code : "# Golo is fun"
        }
    }),

    Editor : Backbone.LazyView.extend({
        el:"#editor",
        template:function() {/*
         <pre><code id="code"><button class="btn btn-primary btn-mini pull-right">RUN</button></code></pre>
         <pre><code id="result"></code></pre>
         */},
        initialized : function(args) {
            //only if you want
        },
        render:function(){

            //this.display({model:this.model});
            this.display({});

            this.editor = CodeMirror(this.$el.find("#code")[0], {
                mode: "golo",
                theme : "solarized",
                //styleActiveLine: true,
                //lineNumbers : true,
                value: this.model.get("code")
            });

            this.editor.setSize("100%","100%")

            this.result = CodeMirror(this.$el.find("#result")[0], {
                theme : "rubyblue",
                //lineNumbers : true,
                value: this.model.get("result")
            });

            this.result.setSize("100%","100%")

        },
        events:{
            "click button" : function(){
                var thisView = this;

                this.model.set({code:this.editor.doc.getValue()})

                this.model.save({},{success:function(data){

                    thisView.render()

                }})

            }
        }
    }),

    SimpleEditor : Backbone.LazyView.extend({
        el:"#editor",
        template:function() {/*
         <pre><code id="code"><button class="btn btn-primary btn-mini pull-right">SAVE</button></code></pre>
         */},
        initialized : function(args) {
            //only if you want
        },
        render:function(){

            //this.display({model:this.model});
            this.display({});

            this.editor = CodeMirror(this.$el.find("#code")[0], {
                mode: "golo",
                theme : "solarized",
                //styleActiveLine: true,
                //lineNumbers : true,
                value: this.model.get("code")
            });

            this.editor.setSize("100%","100%")

        },
        events:{
            "click button" : function(){
                var thisView = this;

                this.model.set({code:this.editor.doc.getValue()})

                this.model.save({},{success:function(data){

                    thisView.render()

                }})

            }
        }
    })
}