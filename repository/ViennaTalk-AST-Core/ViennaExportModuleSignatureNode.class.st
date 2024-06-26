Class {
	#name : 'ViennaExportModuleSignatureNode',
	#superclass : 'ViennaExportComponentNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'private' }
ViennaExportModuleSignatureNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : 'enumerating' }
ViennaExportModuleSignatureNode >> exportedIdentifiersDo: aBlock [

	self do: [ :exportSignature |
		exportSignature exportedIdentifiersDo: aBlock ]
]

{ #category : 'enumerating' }
ViennaExportModuleSignatureNode >> exportsIdentifier: aString [

	self exportedIdentifiersDo: [ :identifier |
		identifier = aString ifTrue: [ ^ true ] ].
	^ false
]

{ #category : 'pretty printing' }
ViennaExportModuleSignatureNode >> formatWith: aViennaAbstractFormatter [

	| exportSignatures |
	exportSignatures := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter
		  join: aViennaAbstractFormatter cr
		  withAll: exportSignatures
]

{ #category : 'testing' }
ViennaExportModuleSignatureNode >> isViennaExportModuleSignatureNode [

	^ true
]

{ #category : 'accessing' }
ViennaExportModuleSignatureNode >> label [

	^ 'ExportModuleSignature'
]

{ #category : 'typechecking' }
ViennaExportModuleSignatureNode >> maximalType [

	self do: #typecheck.
	^ ViennaType unit
]

{ #category : 'removing' }
ViennaExportModuleSignatureNode >> removeIdentifier: aString [

	(self exportsIdentifier: aString) ifTrue: [
		self asArray do: [ :exportSignature |
			exportSignature removeIdentifier: aString ].
		self ifEmpty: [
			parent ifNotNil: [
				parent exportModuleSignature:
					ViennaExportModuleSignatureAllNode empty ] ] ]
]
