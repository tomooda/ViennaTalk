Class {
	#name : #ViennaImportTypesSignatureNode,
	#superclass : #ViennaImportSignatureNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'pretty printing' }
ViennaImportTypesSignatureNode >> formatWith: aViennaAbstractFormatter [

	| typeImports |
	typeImports := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter
		  indentString: (aViennaAbstractFormatter keyword: 'types')
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
