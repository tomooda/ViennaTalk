Class {
	#name : 'ViennaAddSection',
	#superclass : 'ViennaAdd',
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'testing' }
ViennaAddSection class >> isAbstract [

	^ self == ViennaAddSection
]

{ #category : 'accessing' }
ViennaAddSection >> findContainerNode [

	ast ifNil: [ ^ nil ].
	(ast isViennaDocumentNode or: [
		 ast isViennaModuleNode or: [ ast isViennaSectionNode ] ]) ifFalse: [
		^ nil ].
	^ ast module ifNotNil: #moduleBody
]

{ #category : 'instance creation' }
ViennaAddSection >> newAst [

	| newAst |
	newAst := self parser parse: (self sourceWithNewName: nil).
	^ newAst isPetit2Failure
		  ifTrue: [ nil ]
		  ifFalse: [ newAst ]
]

{ #category : 'accessing' }
ViennaAddSection >> newNameQuery [

	^ ''
]

{ #category : 'accessing' }
ViennaAddSection >> parser [

	^ ViennaVDMParser current definitionBlock end
]
