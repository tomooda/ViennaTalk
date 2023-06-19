Class {
	#name : #ViennaExportModuleSignatureAllNode,
	#superclass : #ViennaInterfaceComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaExportModuleSignatureAllNode >> boundIdentifiersInto: aSet [

	
]

{ #category : #'pretty printing' }
ViennaExportModuleSignatureAllNode >> formatWith: aViennaAbstractFormatter [

	^ 'all'
]

{ #category : #testing }
ViennaExportModuleSignatureAllNode >> isViennaExportModuleSignatureAllNode [

	^ true
]

{ #category : #accessing }
ViennaExportModuleSignatureAllNode >> label [

	^ 'ExportModuleSignatureAll'
]
