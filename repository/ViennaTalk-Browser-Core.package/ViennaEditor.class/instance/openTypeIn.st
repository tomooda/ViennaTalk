typing support
openTypeIn
	"Set up startOfTyping to keep track of the leftmost backspace.
	 You can't undo typing until after closeTypeIn."

	template := nil.
	self applyAttribute: TextColor black.
	^ super openTypeIn