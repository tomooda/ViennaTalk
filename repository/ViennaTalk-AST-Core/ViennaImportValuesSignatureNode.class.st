Class {
	#name : #ViennaImportValuesSignatureNode,
	#superclass : #ViennaImportSignatureNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'pretty printing' }
ViennaImportValuesSignatureNode >> formatWith: aViennaAbstractFormatter [

	| valueImports |
	valueImports := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter
		  indentString: (aViennaAbstractFormatter keyword: 'values')
		  insertCrIfNeeded: (aViennaAbstractFormatter
				   join:
				   aViennaAbstractFormatter empty , ';'
				   , aViennaAbstractFormatter cr
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
