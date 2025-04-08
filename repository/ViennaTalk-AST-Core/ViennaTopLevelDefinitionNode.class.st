Class {
	#name : 'ViennaTopLevelDefinitionNode',
	#superclass : 'ViennaNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'testing' }
ViennaTopLevelDefinitionNode class >> isAbstract [

	^ self = ViennaTopLevelDefinitionNode
]

{ #category : 'accessing' }
ViennaTopLevelDefinitionNode >> addToModule: aViennaModuleNode [

	^ self subclassResponsibility
]

{ #category : 'testing' }
ViennaTopLevelDefinitionNode >> allGlobalNamesSatisfy: aBlock [

	self globalNamesDo: [ :globalName |
		(aBlock value: globalName) ifFalse: [ ^ false ] ].
	^ true
]

{ #category : 'testing' }
ViennaTopLevelDefinitionNode >> anyGlobalNamesSatisfy: aBlock [

	self globalNamesDo: [ :globalName |
		(aBlock value: globalName) ifTrue: [ ^ true ] ].
	^ false
]

{ #category : 'accessing' }
ViennaTopLevelDefinitionNode >> globalNames [

	^ Array streamContents: [ :stream |
		  self globalNamesDo: [ :globalName | stream nextPut: globalName ] ]
]

{ #category : 'enumerating' }
ViennaTopLevelDefinitionNode >> globalNamesDo: aBlock [

	self identifiers do: [ :identifier |
		aBlock value: ((ViennaGlobalNameNode
				  moduleIdentifier:
					  (self module ifNotNil: #identifier ifNil: [ 'DEFAULT' ])
				  identifier: identifier)
				 parent: self document;
				 yourself) ]
]

{ #category : 'accessing' }
ViennaTopLevelDefinitionNode >> identifier [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
ViennaTopLevelDefinitionNode >> identifiers [

	^ { self identifier }
]

{ #category : 'testing' }
ViennaTopLevelDefinitionNode >> isViennaExportableTopLevelDefinitionNode [

	^ self subclassResponsibility
]

{ #category : 'testing' }
ViennaTopLevelDefinitionNode >> isViennaTopLevelDefinitionNode [

	^ true
]
