Extension { #name : #ViennaNameNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaNameNode >> sliceWith: aViennaSlicer [

	| resolved |
	resolved := self resolve.
	(resolved isFunctionDefinition or: [ resolved isValueDefinition ])
		ifTrue: [ resolved sliceWith: aViennaSlicer ]
]
