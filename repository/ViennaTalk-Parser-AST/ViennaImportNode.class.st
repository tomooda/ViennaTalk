Class {
	#name : #ViennaImportNode,
	#superclass : #ViennaImportComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaImportNode class >> isAbstract [

	^ self = ViennaImportNode
]

{ #category : #private }
ViennaImportNode >> boundIdentifiersDo: aBlock [

	self rename ifNotNil: aBlock
]

{ #category : #accessing }
ViennaImportNode >> identifier [

	^ self name identifier
]

{ #category : #testing }
ViennaImportNode >> isViennaImportNode [

	^ true
]

{ #category : #testing }
ViennaImportNode >> isViennaImportNode: aString [

	^ self identifier = aString
]

{ #category : #accessing }
ViennaImportNode >> name [

	^ self subclassResponsibility
]

{ #category : #accessing }
ViennaImportNode >> rename [

	^ self subclassResponsibility
]

{ #category : #accessing }
ViennaImportNode >> shortName [

	^ self name shortName
]
