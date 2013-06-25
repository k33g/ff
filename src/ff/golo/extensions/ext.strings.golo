module ext.strings

pimp java.lang.String {
	function append = |this, s| -> this + s

	function log = |this| -> println(this)
}