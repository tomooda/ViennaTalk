typing support
openTypeIn
	"Set up startOfTyping to keep track of the leftmost backspace.
	 You can't undo typing until after closeTypeIn."

	self applyAttribute: TextColor black.
	^ super openTypeIn