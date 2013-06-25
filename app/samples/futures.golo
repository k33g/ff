module futures

import ext.futures

import java.util.LinkedList
import java.util.concurrent.Executors
import java.lang.Thread

function runFuture = {
	let executor = Executors.newFixedThreadPool(50)

	let list = LinkedList()

	let MyCallable = |message, callBackWhenDone| { # add callback
		println("START : " + message)

		var sum = 0
		for (var i = 0, i <50, i = i + 1)  {
			sum = sum + 1
			Thread.sleep(50_L)
		}

		println("END : " + message+"-->"+sum)

		if callBackWhenDone isnt null { callBackWhenDone(message) }

		return sum
	}

	for (var i = 0, i < 25, i = i + 1)  {

		let future = executor:getFuture(
			 MyCallable
			,"future : " + i
			,|arg|{println(arg + " Submitted")}
			,|arg|{println(arg + " Done")}
		)

		Thread.sleep(300_L)

		list:append(future)

		if i is 17 { future:cancelTask(
			|isCancelledBeforeEnd| -> println("*** CANCELLED ***")
		)}
	}

	var sum = 0

	println("Size : " + list:size())

	#Now retrieve the result
	foreach future in list {

		if future:isDone() { #only if future is done

			sum = sum + future:getResult(
				|e| -> println("*** OUPS! I DID IT AGAIN! ***")
			) orIfNull 0

		}
	}

	println("Sum : " + sum)

	executor:shutdown()
}