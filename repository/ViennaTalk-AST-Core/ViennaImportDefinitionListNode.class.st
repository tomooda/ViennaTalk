Class {
	#name : #ViennaImportDefinitionListNode,
	#superclass : #ViennaImportComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
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
		  indentString: (aViennaAbstractFormatter keyword: 'imports')
		  insertCrIfNeeded: (aViennaAbstractFormatter
				   join:
				   aViennaAbstractFormatter empty ++ ','
				   ++ aViennaAbstractFormatter cr
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

{ #category : #private }
ViennaImportDefinitionListNode >> listDelimiter [

	^ ', '
]

{ #category : #typechecking }
ViennaImportDefinitionListNode >> maximalType [

	self do: #typecheck.
	^ ViennaType unit
]
