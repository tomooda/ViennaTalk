copying
postCopy
	| oldState oldSpec |
	oldState := self state.
	oldSpec := self specification.
	super postCopy.
	self initialize.
	self specification: oldSpec.
	self state: oldState