Class {
	#name : #ViennaGlobalNameNode,
	#superclass : #ViennaNameNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaGlobalNameNode class >> moduleIdentifier: aString1 identifier: aString2 [

	^ (self new: 2)
		  moduleIdentifier: aString1;
		  identifier: aString2;
		  yourself
]

{ #category : #'accessing-definitions' }
ViennaGlobalNameNode >> asGlobalName [

	^ self
]

{ #category : #'pretty printing' }
ViennaGlobalNameNode >> formatWith: aViennaAbstractFormatter [

	^ self moduleIdentifier , '`' , self identifier
]

{ #category : #'parsers-symbols' }
ViennaGlobalNameNode >> identifier [

	^ self at: 2
]

{ #category : #'parsers-symbols' }
ViennaGlobalNameNode >> identifier: aString [

	self at: 2 put: aString
]

{ #category : #testing }
ViennaGlobalNameNode >> isExportedNameNode [

	^ true
]

{ #category : #testing }
ViennaGlobalNameNode >> isFunctionNameNode [

	(self moduleNamed: self moduleIdentifier) ifNotNil: [ :moduleNode |
		(moduleNode definitionOfLocalName: self identifier) ifNotNil: [
			:defNode |
			((defNode isViennaExplicitFunctionDefinitionNode: self identifier)
				 or: [
					 (#( 'ImplicitFunctionDefinition' ) includes: defNode label)
						 and: [ defNode first = self identifier ] ]) ifTrue: [ ^ true ] ] ].
	^ false
]

{ #category : #testing }
ViennaGlobalNameNode >> isOperationNameNode [

	(self moduleNamed: self moduleIdentifier) ifNotNil: [ :moduleNode |
		(moduleNode definitionOfLocalName: self identifier) ifNotNil: [
			:defNode |
			(defNode isViennaExplicitOperationDefinitionNode: self identifier)
				ifTrue: [ ^ true ].
			((#( 'ImplicitOperationDefinition' ) includes: defNode label) and: [
				 defNode first = self identifier ]) ifTrue: [ ^ true ] ] ].
	^ false
]

{ #category : #testing }
ViennaGlobalNameNode >> isTypeNameNode [

	(self moduleNamed: self moduleIdentifier) ifNotNil: [ :moduleNode |
		(moduleNode definitionOfLocalName: self identifier) ifNotNil: [
			:defNode |
			(defNode isViennaTypeSynonymNode: self identifier) ifTrue: [
				^ true ].
			((#( 'RecordTypeDefinition' ) includes: defNode label) and: [
				 defNode first = self identifier ]) ifTrue: [ ^ true ] ] ].
	^ false
]

{ #category : #testing }
ViennaGlobalNameNode >> isValueNameNode [

	(self moduleNamed: self moduleIdentifier) ifNotNil: [ :moduleNode |
		(moduleNode definitionOfLocalName: self identifier) ifNotNil: [
			:defNode |
			defNode bindHolderNode label = 'ValueDefinition' ifTrue: [ ^ true ] ] ].
	^ false
]

{ #category : #testing }
ViennaGlobalNameNode >> isViennaGlobalNameNode [

	^ true
]

{ #category : #testing }
ViennaGlobalNameNode >> isViennaGlobalNameNode: aString identifier: anotherString [

	^ self moduleIdentifier = aString and: [
		  self identifier = anotherString ]
]

{ #category : #accessing }
ViennaGlobalNameNode >> label [

	^ 'GlobalName'
]

{ #category : #'parsers-symbols' }
ViennaGlobalNameNode >> moduleIdentifier [

	^ self at: 1
]

{ #category : #'parsers-symbols' }
ViennaGlobalNameNode >> moduleIdentifier: aString [

	self at: 1 put: aString
]

{ #category : #'accessing-definitions' }
ViennaGlobalNameNode >> resolve [

	^ (self moduleNamed: self moduleIdentifier) ifNotNil: [ :module |
		  module resolveLocalName: self identifier ]
]

{ #category : #'pretty printing' }
ViennaGlobalNameNode >> shortName [

	^ self moduleIdentifier , '`' , self identifier
]
