Class {
	#name : #ViennaExportOperationsSignatureNode,
	#superclass : #ViennaExportSignatureNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'pretty printing' }
ViennaExportOperationsSignatureNode >> formatWith: aViennaAbstractFormatter [

	| signatures |
	signatures := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter
		  indentString: (aViennaAbstractFormatter keyword: 'operations')
		  insertCrIfNeeded: (aViennaAbstractFormatter
				   join:
				   aViennaAbstractFormatter empty ++ ';'
				   ++ aViennaAbstractFormatter cr
				   withAll: signatures) ++ ';'
]

{ #category : #testing }
ViennaExportOperationsSignatureNode >> isViennaExportOperationsSignatureNode [

	^ true
]

{ #category : #accessing }
ViennaExportOperationsSignatureNode >> label [

	^ 'ExportOperationsSignature'
]
