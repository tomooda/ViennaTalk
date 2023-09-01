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

{ #category : #converting }
ViennaImportNode >> asGlobalName [

	^ ViennaGlobalNameNode
		  moduleIdentifier: self moduleIdentifier
		  identifier: self identifier
]

{ #category : #private }
ViennaImportNode >> boundIdentifiersDo: aBlock [

	self rename ifNotNil: [ :name |
		aBlock cull: name identifier cull: self ]
]

{ #category : #accessing }
ViennaImportNode >> identifier [

	^ self name identifier
]

{ #category : #accessing }
ViennaImportNode >> identifier: aString [

	^ self name identifier: aString
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
ViennaImportNode >> moduleIdentifier [

	^ parent ifNotNil: #moduleIdentifier
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
