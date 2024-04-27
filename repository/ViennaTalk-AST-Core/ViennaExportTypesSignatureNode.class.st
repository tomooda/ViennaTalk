Class {
	#name : #ViennaExportTypesSignatureNode,
	#superclass : #ViennaExportSignatureNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'pretty printing' }
ViennaExportTypesSignatureNode >> formatWith: aViennaAbstractFormatter [

	| typeExports |
	typeExports := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter
		  indentString: (aViennaAbstractFormatter keyword: 'types')
		  insertCrIfNeeded:
			  (aViennaAbstractFormatter
				   join: ';' , String cr
				   withAll: typeExports) , ';'
]

{ #category : #testing }
ViennaExportTypesSignatureNode >> isViennaExportTypesSignatureNode [

	^ true
]

{ #category : #accessing }
ViennaExportTypesSignatureNode >> label [

	^ 'ExportTypesSignature'
]
