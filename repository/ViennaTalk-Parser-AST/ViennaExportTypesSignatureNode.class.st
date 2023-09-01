Class {
	#name : #ViennaExportTypesSignatureNode,
	#superclass : #ViennaExportSignatureNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaExportTypesSignatureNode >> formatWith: aViennaAbstractFormatter [

	| typeExports |
	typeExports := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter
		  indentString: 'types'
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
