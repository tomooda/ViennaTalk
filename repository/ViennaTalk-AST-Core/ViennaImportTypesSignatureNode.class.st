Class {
	#name : 'ViennaImportTypesSignatureNode',
	#superclass : 'ViennaImportSignatureNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'pretty printing' }
ViennaImportTypesSignatureNode >> formatWith: aViennaAbstractFormatter [

	| typeImports |
	typeImports := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter
		  indentString: (aViennaAbstractFormatter keyword: 'types')
		  insertCrIfNeeded: (aViennaAbstractFormatter
				   join:
				   aViennaAbstractFormatter empty ++ ';'
				   ++ aViennaAbstractFormatter cr
				   withAll: typeImports) ++ ';'
]

{ #category : 'testing' }
ViennaImportTypesSignatureNode >> isViennaImportTypesSignatureNode [

	^ true
]

{ #category : 'testing' }
ViennaImportTypesSignatureNode >> label [

	^ 'ImportTypesSignature'
]
