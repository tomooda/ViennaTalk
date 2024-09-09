Extension { #name : 'ViennaNameNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaNameNode >> sliceArgumentsWith: aViennaSlicer [

	
]

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaNameNode >> sliceReadWith: aViennaSlicer [

	aViennaSlicer onNode: self
]

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaNameNode >> sliceWith: aViennaSlicer [

	| resolved |
	resolved := self resolve.
	aViennaSlicer onNode: self do: [  ].
	(resolved notNil and: [ resolved isViennaPatternIdentifierNode ])
		ifTrue: [ resolved sliceWith: aViennaSlicer ].
	(resolved isValueDefinition and: [
		 resolved isViennaTopLevelDefinitionNode ]) ifTrue: [
		resolved sliceWith: aViennaSlicer ]
]

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaNameNode >> sliceWriteWith: aViennaSlicer [

	aViennaSlicer onNode: self.
	aViennaSlicer write: self
]
