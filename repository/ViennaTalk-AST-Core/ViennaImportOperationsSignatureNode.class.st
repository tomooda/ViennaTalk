Class {
	#name : #ViennaImportOperationsSignatureNode,
	#superclass : #ViennaImportSignatureNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'pretty printing' }
ViennaImportOperationsSignatureNode >> formatWith: aViennaAbstractFormatter [

	| operationImports |
	operationImports := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter
		  indentString: (aViennaAbstractFormatter keyword: 'operations')
		  insertCrIfNeeded: (aViennaAbstractFormatter
				   join:
				   aViennaAbstractFormatter empty ++ ';'
				   ++ aViennaAbstractFormatter cr
				   withAll: operationImports) ++ ';'
]

{ #category : #testing }
ViennaImportOperationsSignatureNode >> isViennaImportOperationsSignatureNode [

	^ true
]

{ #category : #testing }
ViennaImportOperationsSignatureNode >> label [

	^ 'ImportOperationsSignature'
]
