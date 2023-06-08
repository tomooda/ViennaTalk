Class {
	#name : #ViennaTypeImportNode,
	#superclass : #ViennaInterfaceComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'as yet unclassified' }
ViennaTypeImportNode >> isViennaTypeImportNode [

	^ true
]

{ #category : #'as yet unclassified' }
ViennaTypeImportNode >> label [

	^ 'TypeImport'
]
