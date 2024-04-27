Class {
	#name : #ViennaGlobalNameNode,
	#superclass : #ViennaNameNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
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

{ #category : #'accessing-definitions' }
ViennaGlobalNameNode >> definition [

	^ self
		  definitionOfGlobalName: self identifier
		  module: self moduleIdentifier
]

{ #category : #'pretty printing' }
ViennaGlobalNameNode >> formatWith: aViennaAbstractFormatter [

	^ (aViennaAbstractFormatter moduleName: self moduleIdentifier) ++ '`'
	  ++ (aViennaAbstractFormatter identifier: self identifier)
]

{ #category : #private }
ViennaGlobalNameNode >> freeIdentifiersExcept: aSet do: aBlock [
]

{ #category : #accessing }
ViennaGlobalNameNode >> identifier [

	^ self at: 2
]

{ #category : #accessing }
ViennaGlobalNameNode >> identifier: aString [

	self at: 2 put: aString
]

{ #category : #testing }
ViennaGlobalNameNode >> isAssignable [

	^ false
]

{ #category : #testing }
ViennaGlobalNameNode >> isExportedNameNode [

	^ true
]

{ #category : #testing }
ViennaGlobalNameNode >> isFunctionNameNode [

	^ self resolve
		  ifNotNil: [ :def | def isFunctionDefinition ]
		  ifNil: [ false ]
]

{ #category : #testing }
ViennaGlobalNameNode >> isOperationNameNode [

	^ self resolve
		  ifNotNil: [ :def | def isOperationDefinition ]
		  ifNil: [ false ]
]

{ #category : #testing }
ViennaGlobalNameNode >> isTypeNameNode [

	^ self resolve
		  ifNotNil: [ :def | def isTypeDefinition ]
		  ifNil: [ false ]
]

{ #category : #testing }
ViennaGlobalNameNode >> isValueNameNode [

	^ self resolve
		  ifNotNil: [ :def | def isValueDefinition ]
		  ifNil: [ false ]
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

{ #category : #'accessing-definitions' }
ViennaGlobalNameNode >> localResolve [

	^ (self module importDefinitionAtModuleIdentifier:
		   self module identifier) ifNotNil: [ :importDefinition |
		  importDefinition importModuleSignature ifNotNil: [ :signature |
			  signature isViennaImportModuleSignatureAllNode
				  ifTrue: [ signature ]
				  ifFalse: [
					  signature
						  detect: [ :import | import identifier = self identifier ]
						  ifNone: [ nil ] ] ] ]
]

{ #category : #accessing }
ViennaGlobalNameNode >> moduleIdentifier [

	^ self at: 1
]

{ #category : #accessing }
ViennaGlobalNameNode >> moduleIdentifier: aString [

	self at: 1 put: aString
]

{ #category : #'accessing-definitions' }
ViennaGlobalNameNode >> resolve [

	^ (self moduleNamed: self moduleIdentifier) ifNotNil: [ :module |
		  module resolveIdentifier: self identifier ]
]

{ #category : #'pretty printing' }
ViennaGlobalNameNode >> shortName [

	^ self moduleIdentifier , '`' , self identifier
]
