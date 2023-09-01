Extension { #name : #ViennaNameNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaNameNode >> sliceWith: aViennaSlicer [

	| resolved |
	resolved := self resolve.
	resolved isFunctionDefinition ifTrue: [
		resolved sliceWith: aViennaSlicer ]
]
