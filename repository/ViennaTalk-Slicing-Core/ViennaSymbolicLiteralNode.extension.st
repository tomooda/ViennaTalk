Extension { #name : #ViennaSymbolicLiteralNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaSymbolicLiteralNode >> sliceWith: aViennaIntraOperationSlicer [

	aViennaIntraOperationSlicer
		onNode: self
		do: [ aViennaIntraOperationSlicer write: self ]
]
