Class {
	#name : #ViennaImportOperationsSignatureNode,
	#superclass : #ViennaImportSignatureNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaImportOperationsSignatureNode >> formatWith: aViennaAbstractFormatter [

	| operationImports |
	operationImports := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter
		  indentString: 'operations'
		  insertCrIfNeeded: (aViennaAbstractFormatter
				   join: ';' , String cr
				   withAll: operationImports) , ';'
]

{ #category : #testing }
ViennaImportOperationsSignatureNode >> isViennaImportOperationsSignatureNode [

	^ true
]

{ #category : #testing }
ViennaImportOperationsSignatureNode >> label [

	^ 'ImportOperationsSignature'
]
