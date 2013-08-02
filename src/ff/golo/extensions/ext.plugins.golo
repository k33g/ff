module core.plugins

struct plugin = {foo}
struct jar = {pluginKey, fileName}
struct classDef = {pluginKey, packageName, className}

augment core.plugins.types.plugin {
    function load = |this, jarstru| -> ff.plugins.Plugins.loadJar(jarstru:pluginKey(), jarstru:fileName())

    function klass = |this, classDefstru| {
        return ff.plugins.Plugins.getClass(
            classDefstru:pluginKey(),
            (classDefstru:packageName()+"."+classDefstru:className()):toString()
        )
    }

}


#    function getlass = |this, classDefstru|
#        -> ff.plugins.Plugins.getClass(classDefstru:pluginKey(), classDefstru:package()+"."+classDefstru:className())