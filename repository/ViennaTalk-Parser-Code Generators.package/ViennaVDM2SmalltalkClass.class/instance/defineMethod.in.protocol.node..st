utilities
defineMethod: aString in: aClass protocol: protocol node: aViennaNode
	| selector |
	selector := aClass
		compile: (RBParser parseMethod: aString asString) formattedCode
		classified: protocol.
	aClass specificationAt: selector put: aViennaNode