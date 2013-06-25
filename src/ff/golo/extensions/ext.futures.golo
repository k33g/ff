module ext.futures

augment java.util.concurrent.Future {

	function getResult = |this, callBackWhenException| {
		var r  = null
		try {
			r = this:get()
		} catch (e) {
			callBackWhenException(e)
		} finally {
			return r
		}
	}

	function cancelTask = |this, callBackWhenCancelled| {
		this:cancel(true)
		callBackWhenCancelled(this:isCancelled())
	}
}

augment java.util.concurrent.ExecutorService {
	# callable : closure to execute
	# message : argument passed to callable
	# callBackWhenSubmitted :
	#  - called when callable is submitted by ExecutorService
	#  - message is passed as parameter of callBackWhenSubmitted
	# callBackWhenDone : passed as 2nd parameter of the callable
	function getFuture = |this, callable, message, callBackWhenSubmitted, callBackWhenDone| {
		let worker = (-> callable(message, callBackWhenDone)):to(java.util.concurrent.Callable.class)
		callBackWhenSubmitted(message)
		return this:submit(worker) #future is run when submit()
	}
}