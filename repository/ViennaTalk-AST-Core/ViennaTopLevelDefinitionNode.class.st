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

{ #category : 'enumerating' }
ViennaTopLevelDefinitionNode >> globalNamesDo: aBlock [

	self identifiers do: [ :identifier |
		aBlock value: ((ViennaGlobalNameNode
				  moduleIdentifier: self module identifier
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
