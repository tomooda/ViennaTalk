Class {
	#name : #ViennaImportDefinitionNode,
	#superclass : #ViennaInterfaceComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'as yet unclassified' }
ViennaImportDefinitionNode class >> moduleIdentifier: aString importModuleSignature: aViennaImportModuleSignatureNode [

	^ (self new: 2)
		  moduleIdentifier: aString;
		  importModuleSignature: aViennaImportModuleSignatureNode;
		  yourself
]

{ #category : #'pretty printing' }
ViennaImportDefinitionNode >> formatWith: aViennaAbstractFormatter [

	| moduleIdentifier moduleSignature |
	moduleIdentifier := aViennaAbstractFormatter format:
		                    self moduleIdentifier.
	moduleSignature := aViennaAbstractFormatter format:
		                   self importModuleSignature.
	^ aViennaAbstractFormatter
		  indentString: 'from ' , moduleIdentifier
		  insertCrIfNeeded: moduleSignature
]

{ #category : #'parsers-symbols' }
ViennaImportDefinitionNode >> importModuleSignature [

	^ self at: 2
]

{ #category : #'parsers-symbols' }
ViennaImportDefinitionNode >> importModuleSignature: aViennaImportModuleSignatureNode [

	^ self at: 2 put: aViennaImportModuleSignatureNode
]

{ #category : #testing }
ViennaImportDefinitionNode >> isViennaImportDefinitionNode [

	^ true
]

{ #category : #testing }
ViennaImportDefinitionNode >> label [

	^ 'ImportDefinition'
]

{ #category : #'parsers-symbols' }
ViennaImportDefinitionNode >> moduleIdentifier [

	^ self at: 1
]

{ #category : #'parsers-symbols' }
ViennaImportDefinitionNode >> moduleIdentifier: aString [

	self at: 1 put: aString
]

{ #category : #testing }
ViennaImportDefinitionNode >> name [

	^ self moduleIdentifier
]
