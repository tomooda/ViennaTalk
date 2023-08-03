Extension { #name : #ViennaNameNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaNameNode >> sliceWith: aViennaSlicer [

	| resolved |
	resolved := self resolve.
	self ~= resolved ifTrue: [ resolved sliceWith: aViennaSlicer ]
]
