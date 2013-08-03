module boot

import core.stores

function boot = |arg| {
    println("=== >>> Booting ... ===")

    memory():save("db","...")

    println("=== >>> Ignition !!! GO ===")

}
