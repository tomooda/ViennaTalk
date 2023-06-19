Class {
	#name : #ViennaTrapsNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaTrapsNode >> boundIdentifiersInto: aSet [

	
]

{ #category : #'pretty printing' }
ViennaTrapsNode >> formatWith: aViennaAbstractFormatter [

	^ '{' , (self
		   ifNotEmpty: [
			   aViennaAbstractFormatter
				   join: ',' , String cr
				   withAll: ((1 to: self size by: 2) collect: [ :index |
						    (aViennaAbstractFormatter format: (self at: index))
						    , ' |-> ' , (aViennaAbstractFormatter indentString:
							     (aViennaAbstractFormatter format: (self at: index + 1))) ]) ]
		   ifEmpty: [ '' ]) , '}'
]

{ #category : #testing }
ViennaTrapsNode >> isViennaTrapsNode [

	^ true
]

{ #category : #accessing }
ViennaTrapsNode >> label [

	^ 'Traps'
]
