Class {
	#name : #ViennaExportOperationsSignatureNode,
	#superclass : #ViennaExportSignatureNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaExportOperationsSignatureNode >> formatWith: aViennaAbstractFormatter [

	| signatures |
	signatures := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter
		  indentString: 'operations'
		  insertCrIfNeeded:
			  (aViennaAbstractFormatter
				   join: ';' , String cr
				   withAll: signatures) , ';'
]

{ #category : #testing }
ViennaExportOperationsSignatureNode >> isViennaExportOperationsSignatureNode [

	^ true
]

{ #category : #accessing }
ViennaExportOperationsSignatureNode >> label [

	^ 'ExportOperationsSignature'
]
