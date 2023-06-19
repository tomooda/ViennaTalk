Class {
	#name : #ViennaImportModuleSignatureAllNode,
	#superclass : #ViennaInterfaceComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaImportModuleSignatureAllNode >> boundIdentifiersInto: aSet [

	
]

{ #category : #'pretty printing' }
ViennaImportModuleSignatureAllNode >> formatWith: aViennaAbstractFormatter [

	^ 'all'
]

{ #category : #testing }
ViennaImportModuleSignatureAllNode >> isViennaImportModuleSignatureAllNode [

	^ true
]

{ #category : #testing }
ViennaImportModuleSignatureAllNode >> label [

	^ 'ImportModuleSignatureAll'
]
