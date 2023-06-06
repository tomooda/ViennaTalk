Class {
	#name : #ViennaDclStatementNode,
	#superclass : #ViennaStatementNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'accessing-definitions' }
ViennaDclStatementNode >> definitionOfLocalName: aString [

	^ self
		  detect: [ :assignmentDefinition |
		  assignmentDefinition identifier = aString ]
		  ifNone: [
		  parent ifNotNil: [ parent definitionOfLocalName: aString ] ]
]

{ #category : #'pretty printing' }
ViennaDclStatementNode >> formatWith: aViennaAbstractFormatter [

	| assigns |
	assigns := aViennaAbstractFormatter formatAll: self.
	^ 'dcl' , ((aViennaAbstractFormatter anyNeedsIndent: assigns)
		   ifTrue: [
			   String cr , aViennaAbstractFormatter indent
			   ,
			   (aViennaAbstractFormatter
				    indentAllStrings: assigns
				    withSeparator: ',') ]
		   ifFalse: [
			   String space
			   , (aViennaAbstractFormatter join: ', ' withAll: assigns) ])
]

{ #category : #testing }
ViennaDclStatementNode >> isViennaDclStatementNode [

	^ true
]

{ #category : #accessing }
ViennaDclStatementNode >> label [

	^ 'DclStatement'
]
