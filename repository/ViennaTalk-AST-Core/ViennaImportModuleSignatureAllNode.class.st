Class {
	#name : #ViennaImportModuleSignatureAllNode,
	#superclass : #ViennaImportComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #private }
ViennaImportModuleSignatureAllNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : #'pretty printing' }
ViennaImportModuleSignatureAllNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter keyword: 'all'
]

{ #category : #enumerating }
ViennaImportModuleSignatureAllNode >> importSignaturesDo: aBlock [

	
]

{ #category : #enumerating }
ViennaImportModuleSignatureAllNode >> importsDo: aBlock [
]

{ #category : #testing }
ViennaImportModuleSignatureAllNode >> isViennaImportModuleSignatureAllNode [

	^ true
]

{ #category : #testing }
ViennaImportModuleSignatureAllNode >> label [

	^ 'ImportModuleSignatureAll'
]

{ #category : #typechecking }
ViennaImportModuleSignatureAllNode >> maximalType [

	^ ViennaType unit
]

{ #category : #accessing }
ViennaImportModuleSignatureAllNode >> moduleIdentifier [

	^ parent ifNotNil: #moduleIdentifier
]
