Extension { #name : 'ViennaInvariantNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaInvariantNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer
			write: self;
			read: self invariantInitialFunction ].
	self invariantInitialFunction sliceWith: aViennaSlicer
]
