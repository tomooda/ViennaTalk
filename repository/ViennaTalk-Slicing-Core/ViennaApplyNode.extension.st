Extension { #name : #ViennaApplyNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaApplyNode >> sliceWith: aViennaSlicer [

	aViennaSlicer call: self
]
