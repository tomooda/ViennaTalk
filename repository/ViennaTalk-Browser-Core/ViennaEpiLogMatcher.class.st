Class {
	#name : 'ViennaEpiLogMatcher',
	#superclass : 'Object',
	#traits : 'TComparable',
	#classTraits : 'TComparable classTrait',
	#category : 'ViennaTalk-Browser-Core-EpiLog',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'EpiLog'
}

{ #category : 'instance creation' }
ViennaEpiLogMatcher class >> all [

	^ ViennaEpiLogAllMatcher new
]

{ #category : 'instance creation' }
ViennaEpiLogMatcher class >> branches: aViennaEpiLog [

	^ ViennaEpiLogBranchMatcher from: aViennaEpiLog
]

{ #category : 'instance creation' }
ViennaEpiLogMatcher class >> executionClosureFrom: aViennaEpiLog enumerator: aViennaEpiLogEnumerator at: anotherViennaEpiLog [

	^ ViennaEpiLogExecutionClosureMatcher
		  fromEpiLog: aViennaEpiLog
		  enumerator: aViennaEpiLogEnumerator
		  at: anotherViennaEpiLog
]

{ #category : 'instance creation' }
ViennaEpiLogMatcher class >> heads: aViennaEpiLog [

	^ ViennaEpiLogHeadMatcher from: aViennaEpiLog
]

{ #category : 'instance creation' }
ViennaEpiLogMatcher class >> identifier: aString module: anotherString [

	^ ViennaEpiLogDefinitionMatcher new
		  identifier: aString;
		  moduleName: anotherString;
		  yourself
]

{ #category : 'testing' }
ViennaEpiLogMatcher class >> isAbstract [

	^ self = ViennaEpiLogMatcher
]

{ #category : 'instance creation' }
ViennaEpiLogMatcher class >> module: aString [

	^ ViennaEpiLogModuleMatcher new
		  moduleName: aString;
		  yourself
]

{ #category : 'instance creation' }
ViennaEpiLogMatcher class >> semanticClosureFrom: aViennaEpiLog enumerator: aViennaEpiLogEnumerator at: anotherViennaEpiLog [

	^ ViennaEpiLogSemanticClosureMatcher
		  fromEpiLog: aViennaEpiLog
		  enumerator: aViennaEpiLogEnumerator
		  at: anotherViennaEpiLog
]

{ #category : 'instance creation' }
ViennaEpiLogMatcher class >> syntacticClosureFrom: aViennaEpiLog enumerator: aViennaEpiLogEnumerator at: anotherViennaEpiLog [

	^ ViennaEpiLogSyntacticClosureMatcher
		  fromEpiLog: aViennaEpiLog
		  enumerator: aViennaEpiLogEnumerator
		  at: anotherViennaEpiLog
]

{ #category : 'instance creation' }
ViennaEpiLogMatcher class >> tag: aString [

	^ ViennaEpiLogTagMatcher new
		  tag: aString;
		  yourself
]

{ #category : 'comparing' }
ViennaEpiLogMatcher >> < aViennaEpiLog [
	"Answer whether the receiver is less than the argument."

	^ self order < aViennaEpiLog order or: [
		  self order = aViennaEpiLog order and: [
			  self name < aViennaEpiLog name ] ]
]

{ #category : 'comparing' }
ViennaEpiLogMatcher >> = aViennaEpiLog [

	^ self class = aViennaEpiLog class and: [
		  self order = aViennaEpiLog order and: [
			  self name = aViennaEpiLog name ] ]
]

{ #category : 'comparing' }
ViennaEpiLogMatcher >> hash [

	^ self order hash bitXor: self name hash
]

{ #category : 'accessing' }
ViennaEpiLogMatcher >> icon [

	^ nil
]

{ #category : 'accessing' }
ViennaEpiLogMatcher >> name [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
ViennaEpiLogMatcher >> order [

	^ self subclassResponsibility
]

{ #category : 'printing' }
ViennaEpiLogMatcher >> printOn: aStream [

	aStream nextPutAll: self name
]

{ #category : 'evaluation' }
ViennaEpiLogMatcher >> value: aViennaEpiLog [

	^ self subclassResponsibility
]
