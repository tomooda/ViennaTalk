Class {
	#name : 'ViennaExportTypesSignatureNode',
	#superclass : 'ViennaExportSignatureNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'pretty printing' }
ViennaExportTypesSignatureNode >> formatWith: aViennaAbstractFormatter [

	| typeExports |
	typeExports := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter
		  indentString: (aViennaAbstractFormatter keyword: 'types')
		  insertCrIfNeeded: (aViennaAbstractFormatter
				   join:
				   aViennaAbstractFormatter empty ++ ';'
				   ++ aViennaAbstractFormatter cr
				   withAll: typeExports) ++ ';'
]

{ #category : 'testing' }
ViennaExportTypesSignatureNode >> isViennaExportTypesSignatureNode [

	^ true
]

{ #category : 'accessing' }
ViennaExportTypesSignatureNode >> label [

	^ 'ExportTypesSignature'
]
