Class {
	#name : #ViennaImportValuesSignatureNode,
	#superclass : #ViennaImportSignatureNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaImportValuesSignatureNode >> formatWith: aViennaAbstractFormatter [

	| valueImports |
	valueImports := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter
		  indentString: 'values'
		  insertCrIfNeeded:
			  (aViennaAbstractFormatter
				   join: ';' , String cr
				   withAll: valueImports) , ';'
]

{ #category : #testing }
ViennaImportValuesSignatureNode >> isViennaImportValuesSignatureNode [

	^ true
]

{ #category : #testing }
ViennaImportValuesSignatureNode >> label [

	^ 'ImportValuesSignature'
]
