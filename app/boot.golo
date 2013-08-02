module boot

import models.project
import models.user
import models.bug
import models.human

import core.stores
import core.plugins

import java.util.concurrent.Executors
import core.futures

import java.io.File

function boot = |arg| {
    println("=== >>> Booting ... ===")

    # You can store everything in memory
    # memory is an augmented structure : set / get / delete
    # This is a test
    memory():save("author","### K33G_ORG ###")

    println("Application directory : /%s":format(ff.Parameters.appDirectory()))

    #Using plugins

    plugin():load(                          # plugin is an augmented structure
        jar()                               # jar is a structure
            :pluginKey("42")                # a reference of the plugin
            :fileName("fourtyTwo.jar")      # plugins are always in <app>/plugins directory
    )

    #Get Class of a plugin
    let H2G2 = plugin():klass(
        classDef()
            :pluginKey("42")
            :packageName("org.fourtytwo")
            :className("H2G2")
    )

    #Get Instance of the class of the plugin and play with it
    #let h2g2 = H2G2:newInstance()
    let h2g2 = H2G2:getConstructor(java.lang.String.class):newInstance("hello world")

    println(h2g2:theAnswerToLifeTheUniverseAndEverything("???"))
    println(h2g2:theAnswerToLifeTheUniverseAndEverything())


    println("Loading data ...")
    # Load data if exists
    Projects():deSerialize()
    Users():deSerialize()
    Bugs():deSerialize()
    Humans():deSerialize()

    println("Scheduling saving ...")
    # Save project each 60 seconds after previous save
    let scheduler = Executors.newScheduledThreadPool(1)

    let scheduledFutureWithFixedDelay =
        scheduler:getScheduleFutureWithFixedDelay(futureArgs()
            :command(|message, callBackWhenDone| {
                #println("event : %s":format(message))
                Users():serialize()
                Projects():serialize()
                Bugs():serialize()
                Humans():serialize()
                #if callBackWhenDone isnt null { callBackWhenDone("projects saved") }
            })
            :message("saveall")
            :initialDelay(10_L)                 # first run after 10 seconds
            :delay(20_L)                        # then run it each 60 seconds
            :callback(|arg| -> println(arg) )   # callback when done
        )

    println("=== >>> Ignition !!! GO ===")

}
