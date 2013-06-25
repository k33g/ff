module boot

import futures

import ext.strings



function boot = |arg| {
    println("=== Booting ... ===")

    #runFuture()

    "Hello":append(" "):append("World"):append("! %s"):format("Bob"):log()


}
