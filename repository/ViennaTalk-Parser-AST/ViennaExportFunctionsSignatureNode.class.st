Class {
	#name : #ViennaExportFunctionsSignatureNode,
	#superclass : #ViennaExportSignatureNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaExportFunctionsSignatureNode >> formatWith: aViennaAbstractFormatter [

	| functionExports |
	functionExports := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter
		  indentString: 'functions'
		  insertCrIfNeeded: (aViennaAbstractFormatter
				   join: ';' , String cr
				   withAll: functionExports) , ';'
]

{ #category : #accessing }
ViennaExportFunctionsSignatureNode >> isViennaExportFunctionsSignatureNode [

	^ true
]

{ #category : #accessing }
ViennaExportFunctionsSignatureNode >> label [

	^ 'ExportFunctionsSignature'
]
