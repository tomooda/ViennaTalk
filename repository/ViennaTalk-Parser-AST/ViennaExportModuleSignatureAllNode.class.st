Class {
	#name : #ViennaExportModuleSignatureAllNode,
	#superclass : #ViennaExportComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaExportModuleSignatureAllNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : #enumerating }
ViennaExportModuleSignatureAllNode >> exportedIdentifiersDo: aBlock [

	self module uniqueBoundIdentifiersDo: aBlock
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

{ #category : #removing }
ViennaExportModuleSignatureAllNode >> removeIdentifier: aString [

	
]
