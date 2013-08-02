module terminate

import models.project
import models.user
import models.bug
import models.human

function terminate = |arg| {
    println("")
    println("===============================")    
    println(" Hello world, this is the end")

    Projects():serialize()
    Bugs():serialize()
    Users():serialize()
    Humans():serialize()

    println(" Memory has been serialized")
    println(" GOLO IS FUN :)")
    println("===============================")

}

