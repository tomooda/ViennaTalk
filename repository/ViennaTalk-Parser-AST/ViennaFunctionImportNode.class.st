Class {
	#name : #ViennaFunctionImportNode,
	#superclass : #ViennaImportNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'as yet unclassified' }
ViennaFunctionImportNode >> isViennaFunctionImportNode [

	^ true
]

{ #category : #accessing }
ViennaFunctionImportNode >> label [

	^ 'FunctionImport'
]
