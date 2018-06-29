Class {
	#name : #ViennaVDM2SmalltalkTranslatorTest,
	#superclass : #TestCase,
	#instVars : [
		'translator'
	],
	#category : 'ViennaTalk-Value-Tests'
}

{ #category : #running }
ViennaVDM2SmalltalkTranslatorTest >> setUp [
	translator := ViennaVDM2SmalltalkTranslator new
]

{ #category : #testing }
ViennaVDM2SmalltalkTranslatorTest >> test1 [
	self
		assert: (Compiler evaluate: (translator expression parse: '(inverse {"one"|->1, "two"|->2, "three"|->3})(2)'))
		equals: 'two' asArray
]

{ #category : #testing }
ViennaVDM2SmalltalkTranslatorTest >> test2 [
	self
		assert: (Compiler evaluate: (translator expression parse: 'dom ({"one"|->1, "two"|->2, "three"|->3} :> {1,3})'))
		equals:
			{('one' asArray).
			('three' asArray)} asSet
]

{ #category : #testing }
ViennaVDM2SmalltalkTranslatorTest >> test3 [
	self
		assert: (Compiler evaluate: (translator expression parse: '2 in set dom {1|->"one", 2|->"two", 3|->"three"}'))
		equals: true
]

{ #category : #testing }
ViennaVDM2SmalltalkTranslatorTest >> test4 [
	self assert: (Compiler evaluate: (translator expression parse: '(lambda x:int&x+1)(2)')) equals: 3
]

{ #category : #testing }
ViennaVDM2SmalltalkTranslatorTest >> test5 [
	self assert: (Compiler evaluate: (translator expression parse: 'let s = power {<a>, <b>, <c>} in card s')) equals: 8
]

{ #category : #testing }
ViennaVDM2SmalltalkTranslatorTest >> test6 [
	self assert: (Compiler evaluate: (translator expression parse: 'let inc:int->int inc(x)==x+1 in inc(2)')) equals: 3
]

{ #category : #testing }
ViennaVDM2SmalltalkTranslatorTest >> test7 [
	self
		assert: (Compiler evaluate: (translator expression parse: '{ i |-> i+1 | i in set {1,...,9} & i mod 2 = 0}'))
		equals:
			(Dictionary new
				at: 2 put: 3;
				at: 4 put: 5;
				at: 6 put: 7;
				at: 8 put: 9;
				yourself)
]

{ #category : #testing }
ViennaVDM2SmalltalkTranslatorTest >> test8 [
	self
		assert: (Compiler evaluate: (translator expression parse: '{ i+1 |i in set {1,...,9} & i mod 2 = 0}'))
		equals: #(3 5 7 9) asSet
]

{ #category : #testing }
ViennaVDM2SmalltalkTranslatorTest >> test9 [
	self
		assert:
			(Compiler evaluate: (translator expression parse: '[ "0123456789abcdef"(i+1) |i in set {0,...,15} & i mod 2 = 0]'))
		equals: #($0 $2 $4 $6 $8 $a $c $e)
]
