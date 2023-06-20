Class {
	#name : #ViennaAccessFunctionDefinitionNode,
	#superclass : #ViennaObsoleteNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaAccessFunctionDefinitionNode class >> access: aViennaAccessNode functionDefinition: aViennaFunctionDefnitionNode [

	^ (self new: 2)
		  access: aViennaAccessNode;
		  functionDefinition: aViennaFunctionDefnitionNode;
		  yourself
]

{ #category : #accessing }
ViennaAccessFunctionDefinitionNode >> access [

	^ self at: 1
]

{ #category : #accessing }
ViennaAccessFunctionDefinitionNode >> access: aViennaAccessNode [

	self at: 1 put: aViennaAccessNode
]

{ #category : #private }
ViennaAccessFunctionDefinitionNode >> boundIdentifiersDo: aBlock [

	self functionDefinition boundIdentifiersDo: aBlock
]

{ #category : #'pretty printing' }
ViennaAccessFunctionDefinitionNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  join: ' '
		  withAll:
		  ((aViennaAbstractFormatter formatAll: self) reject: #isEmpty)
]

{ #category : #accessing }
ViennaAccessFunctionDefinitionNode >> functionDefinition [

	^ self at: 2
]

{ #category : #accessing }
ViennaAccessFunctionDefinitionNode >> functionDefinition: aViennaFunctionDefinitionNode [

	self at: 2 put: aViennaFunctionDefinitionNode
]

{ #category : #testing }
ViennaAccessFunctionDefinitionNode >> isViennaAccessFunctionDefinitionNode [

	^ true
]

{ #category : #accessing }
ViennaAccessFunctionDefinitionNode >> label [

	^ 'AccessFunctionDefinition'
]

{ #category : #'accessing-definitions' }
ViennaAccessFunctionDefinitionNode >> resolve [

	^ self functionDefinition resolve
]

{ #category : #'accessing-definitions' }
ViennaAccessFunctionDefinitionNode >> shortName [

	^ self functionDefinition shortName
]
