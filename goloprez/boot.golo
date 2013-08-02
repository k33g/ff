module boot

import core.stores

function boot = |arg| {
    println("=== Booting ... ===")

    memory():save("slides",map[])

}
