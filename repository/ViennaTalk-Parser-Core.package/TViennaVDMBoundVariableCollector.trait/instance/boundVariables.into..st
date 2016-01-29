bound variables
boundVariables: aViennaNode into: aSet
	(aViennaNode isString or: [ aViennaNode isNil ])
		ifFalse: [ 
			| selector |
			selector := ('boundVariables' , aViennaNode label , ':into:') asSymbol.
			(self respondsTo: selector)
				ifTrue: [ self perform: selector with: aViennaNode with: aSet ] ]