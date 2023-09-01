Class {
	#name : #ViennaImportDefinitionListNode,
	#superclass : #ViennaImportComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaImportDefinitionListNode >> boundIdentifiersDo: aBlock [

	self do: [ :importDefinition |
		importDefinition boundIdentifiersDo: aBlock ]
]

{ #category : #'pretty printing' }
ViennaImportDefinitionListNode >> formatWith: aViennaAbstractFormatter [

	| definitions |
	definitions := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter
		  indentString: 'imports'
		  insertCrIfNeeded:
		  (aViennaAbstractFormatter
			   join: ',' , String cr
			   withAll: definitions)
]

{ #category : #enumerating }
ViennaImportDefinitionListNode >> importSignaturesDo: aBlock [

	self do: [ :importDefinition |
		importDefinition importSignaturesDo: aBlock ]
]

{ #category : #testing }
ViennaImportDefinitionListNode >> isViennaImportDefinitionListNode [

	^ true
]

{ #category : #testing }
ViennaImportDefinitionListNode >> label [

	^ 'ImportDefinitionList'
]
