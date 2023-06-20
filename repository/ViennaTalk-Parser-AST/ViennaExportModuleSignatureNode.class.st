Class {
	#name : #ViennaExportModuleSignatureNode,
	#superclass : #ViennaExportComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaExportModuleSignatureNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : #enumerating }
ViennaExportModuleSignatureNode >> exportedIdentifiersDo: aBlock [

	self do: [ :exportSignature |
		exportSignature exportedIdentifiersDo: aBlock ]
]

{ #category : #'pretty printing' }
ViennaExportModuleSignatureNode >> formatWith: aViennaAbstractFormatter [

	| exportSignatures |
	exportSignatures := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter join: String cr withAll: exportSignatures
]

{ #category : #testing }
ViennaExportModuleSignatureNode >> isViennaExportModuleSignatureNode [

	^ true
]

{ #category : #accessing }
ViennaExportModuleSignatureNode >> label [

	^ 'ExportModuleSignature'
]

{ #category : #removing }
ViennaExportModuleSignatureNode >> removeIdentifier: aString [

	(self exportsIdentifier: aString) ifTrue: [
		self asArray do: [ :exportSignature |
			exportSignature removeIdentifier: aString ].
		self ifEmpty: [
			parent ifNotNil: [
				parent exportModuleSignature:
					ViennaExportModuleSignatureAllNode empty ] ] ]
]
