Class {
	#name : #ViennaExportValuesSignatureNode,
	#superclass : #ViennaExportSignatureNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaExportValuesSignatureNode >> formatWith: aViennaAbstractFormatter [

	| signatures |
	signatures := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter
		  indentString: 'values'
		  insertCrIfNeeded:
			  (aViennaAbstractFormatter
				   join: ';' , String cr
				   withAll: signatures) , ';'
]

{ #category : #testing }
ViennaExportValuesSignatureNode >> isViennaExportValuesSignatureNode [

	^ true
]

{ #category : #accessing }
ViennaExportValuesSignatureNode >> label [

	^ 'ExportValuesSignature'
]
