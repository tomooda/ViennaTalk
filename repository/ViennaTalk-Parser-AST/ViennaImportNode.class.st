Class {
	#name : #ViennaImportNode,
	#superclass : #ViennaInterfaceComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaImportNode class >> isAbstract [

	^ self = ViennaImportNode
]

{ #category : #private }
ViennaImportNode >> boundIdentifiersInto: aSet [

	self rename ifNotNil: [ :rename | aSet value: rename ]
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
