Class {
	#name : #ViennaImportFunctionsSignatureNode,
	#superclass : #ViennaImportSignatureNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'pretty printing' }
ViennaImportFunctionsSignatureNode >> formatWith: aViennaAbstractFormatter [

	| functionImport |
	functionImport := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter
		  indentString: (aViennaAbstractFormatter keyword: 'functions')
		  insertCrIfNeeded: (aViennaAbstractFormatter
				   join:
				   aViennaAbstractFormatter empty , ';'
				   , aViennaAbstractFormatter cr
				   withAll: functionImport) , ';'
]

{ #category : #testing }
ViennaImportFunctionsSignatureNode >> isViennaImportFunctionsSignatureNode [

	^ true
]

{ #category : #testing }
ViennaImportFunctionsSignatureNode >> label [

	^ 'ImportFunctionsSignature'
]
