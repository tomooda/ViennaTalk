copying
postCopy
	| oldSpec oldState |
	super postCopy.
	oldSpec := self specification.
	oldState := self state.
	announceur := nil.
	dependents := nil.
	self initialize.
	self specification: oldSpec.
	self state: oldState