utilities
defineMethod: aString in: aClass protocol: protocol
	aClass compile: (RBParser parseMethod: aString) formattedCode classified: protocol