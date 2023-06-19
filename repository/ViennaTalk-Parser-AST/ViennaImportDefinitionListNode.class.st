Class {
	#name : #ViennaImportDefinitionListNode,
	#superclass : #ViennaInterfaceComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaImportDefinitionListNode >> boundIdentifiersInto: aSet [

	self do: [ :importDefinition |
		importDefinition boundIdentifiersInto: aSet ]
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

{ #category : #testing }
ViennaImportDefinitionListNode >> isViennaImportDefinitionListNode [

	^ true
]

{ #category : #testing }
ViennaImportDefinitionListNode >> label [

	^ 'ImportDefinitionList'
]
