Class {
	#name : #ViennaImportTypesSignatureNode,
	#superclass : #ViennaImportSignatureNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaImportTypesSignatureNode >> formatWith: aViennaAbstractFormatter [

	| typeImports |
	typeImports := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter
		  indentString: 'types'
		  insertCrIfNeeded:
			  (aViennaAbstractFormatter
				   join: ';' , String cr
				   withAll: typeImports) , ';'
]

{ #category : #testing }
ViennaImportTypesSignatureNode >> isViennaImportTypesSignatureNode [

	^ true
]

{ #category : #testing }
ViennaImportTypesSignatureNode >> label [

	^ 'ImportTypesSignature'
]
