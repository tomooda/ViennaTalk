Class {
	#name : 'ViennaRenameToplevelFunction',
	#superclass : 'ViennaRenameToplevel',
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'testing' }
ViennaRenameToplevelFunction >> acceptsDefinitionNode: aViennaNode [

	^ aViennaNode isViennaAccessFunctionDefinitionNode and: [
		  aViennaNode identifier = self oldName ]
]

{ #category : 'accessing' }
ViennaRenameToplevelFunction >> construct [
	^ 'function'
]

{ #category : 'accessing' }
ViennaRenameToplevelFunction >> sortingOrder [
	^ 1.13
]
