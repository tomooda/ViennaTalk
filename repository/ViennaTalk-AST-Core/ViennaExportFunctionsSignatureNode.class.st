Class {
	#name : #ViennaExportFunctionsSignatureNode,
	#superclass : #ViennaExportSignatureNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'pretty printing' }
ViennaExportFunctionsSignatureNode >> formatWith: aViennaAbstractFormatter [

	| functionExports |
	functionExports := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter
		  indentString: (aViennaAbstractFormatter keyword: 'functions')
		  insertCrIfNeeded: (aViennaAbstractFormatter
				   join:
				   aViennaAbstractFormatter empty ++ ';'
				   ++ aViennaAbstractFormatter cr
				   withAll: functionExports) ++ ';'
]

{ #category : #accessing }
ViennaExportFunctionsSignatureNode >> isViennaExportFunctionsSignatureNode [

	^ true
]

{ #category : #accessing }
ViennaExportFunctionsSignatureNode >> label [

	^ 'ExportFunctionsSignature'
]
