Class {
	#name : #ViennaValueImportNode,
	#superclass : #ViennaInterfaceComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'as yet unclassified' }
ViennaValueImportNode >> isViennaValueImportNode [

	^ true
]

{ #category : #'as yet unclassified' }
ViennaValueImportNode >> label [

	^ 'ValueImport'
]
