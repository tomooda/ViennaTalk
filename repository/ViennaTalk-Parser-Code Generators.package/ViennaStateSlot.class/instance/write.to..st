meta-object-protocol
write: aValue to: anObject
	super write: aValue to: anObject.
	anObject inv.
	^ aValue