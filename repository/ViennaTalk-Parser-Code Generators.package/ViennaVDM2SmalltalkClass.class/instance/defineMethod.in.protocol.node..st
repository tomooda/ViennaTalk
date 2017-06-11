utilities
defineMethod: aString in: aClass protocol: protocol node: aViennaNode
	| selector |
	selector := aClass
		compile: (RBParser parseMethod: aString) formattedCode
		classified: protocol.
	aClass nodeAt: selector put: aViennaNode