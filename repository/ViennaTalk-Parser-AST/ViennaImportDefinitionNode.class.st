Class {
	#name : #ViennaImportDefinitionNode,
	#superclass : #ViennaImportComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaImportDefinitionNode class >> moduleIdentifier: aString importModuleSignature: aViennaImportModuleSignatureNode [

	^ (self new: 2)
		  moduleIdentifier: aString;
		  importModuleSignature: aViennaImportModuleSignatureNode;
		  yourself
]

{ #category : #private }
ViennaImportDefinitionNode >> boundIdentifiersDo: aBlock [

	self importModuleSignature boundIdentifiersDo: aBlock
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

{ #category : #enumerating }
ViennaImportDefinitionNode >> importsDo: aBlock [

	self importModuleSignature importsDo: aBlock
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
ViennaImportDefinitionNode >> shortName [

	^ self moduleIdentifier
]
