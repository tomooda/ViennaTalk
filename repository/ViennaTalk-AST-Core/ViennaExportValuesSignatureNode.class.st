Class {
	#name : 'ViennaExportValuesSignatureNode',
	#superclass : 'ViennaExportSignatureNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'pretty printing' }
ViennaExportValuesSignatureNode >> formatWith: aViennaAbstractFormatter [

	| signatures |
	signatures := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter
		  indentString: (aViennaAbstractFormatter keyword: 'values')
		  insertCrIfNeeded: (aViennaAbstractFormatter
				   join:
				   aViennaAbstractFormatter empty ++ ';'
				   ++ aViennaAbstractFormatter cr
				   withAll: signatures) ++ ';'
]

{ #category : 'testing' }
ViennaExportValuesSignatureNode >> isViennaExportValuesSignatureNode [

	^ true
]

{ #category : 'accessing' }
ViennaExportValuesSignatureNode >> label [

	^ 'ExportValuesSignature'
]
