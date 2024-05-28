Extension { #name : 'ViennaFieldNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaFieldNode >> sliceWith: aViennaSlicer [

	aViennaSlicer addAffectingNode: self.
	aViennaSlicer onNode: self do: [ aViennaSlicer read: self type ].
	self type sliceWith: aViennaSlicer
]
