copying
postCopy
	| oldState oldSpec |
	oldState := self state.
	oldSpec := self specification.
	super postCopy.
	object := object copy.
	self state: oldState