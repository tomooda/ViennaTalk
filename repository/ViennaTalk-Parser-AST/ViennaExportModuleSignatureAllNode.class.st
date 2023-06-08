Class {
	#name : #ViennaExportModuleSignatureAllNode,
	#superclass : #ViennaInterfaceComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

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
