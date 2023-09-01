Class {
	#name : #ViennaRefactoringTest,
	#superclass : #TestCase,
	#instVars : [
		'spec',
		'successAst',
		'failureAst'
	],
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #testing }
ViennaRefactoringTest class >> isAbstract [

	^ self = ViennaRefactoringTest
]

{ #category : #accessing }
ViennaRefactoringTest >> createSpec [

	^ self subclassResponsibility
]

{ #category : #accessing }
ViennaRefactoringTest >> failureAst [

	^ failureAst ifNil: [ failureAst := self findFailureAst ]
]

{ #category : #accessing }
ViennaRefactoringTest >> failureAst: aViennaNode [

	failureAst := aViennaNode
]

{ #category : #accessing }
ViennaRefactoringTest >> findFailureAst [

	^ self subclassResponsibility
]

{ #category : #accessing }
ViennaRefactoringTest >> findSuccessAst [

	^ self subclassResponsibility
]

{ #category : #accessing }
ViennaRefactoringTest >> resultingSpec [

	^ self subclassResponsibility
]

{ #category : #running }
ViennaRefactoringTest >> setupRefactoring: aViennaRefactoring [

	^ self subclassResponsibility
]

{ #category : #accessing }
ViennaRefactoringTest >> spec [

	^ spec ifNil: [ spec := self createSpec ]
]

{ #category : #accessing }
ViennaRefactoringTest >> spec: aViennaDocumentNode [

	spec := aViennaDocumentNode
]

{ #category : #accessing }
ViennaRefactoringTest >> successAst [

	^ successAst ifNil: [ successAst := self findSuccessAst ]
]

{ #category : #accessing }
ViennaRefactoringTest >> successAst: aViennaNode [

	successAst := aViennaNode
]

{ #category : #accessing }
ViennaRefactoringTest >> targetClass [

	^ Smalltalk at:
		  (self class name copyFrom: 1 to: self class name size - 4)
			  asSymbol
]

{ #category : #tests }
ViennaRefactoringTest >> testCheck [

	| refactoring |
	refactoring := self targetClass new
		               ast: self successAst;
		               yourself.
	self setupRefactoring: refactoring.
	self assert: refactoring check.
	refactoring := self targetClass new
		               ast: self failureAst;
		               yourself.
	self setupRefactoring: refactoring.
	self deny: refactoring check
]

{ #category : #tests }
ViennaRefactoringTest >> testExecute [

	| refactoring |
	refactoring := self targetClass new
		               ast: self successAst;
		               yourself.
	self setupRefactoring: refactoring.
	self assert: refactoring check.
	refactoring execute.
	self assert: self spec source equals: self resultingSpec source.
	self assert: self spec equals: self resultingSpec
]
