Class {
	#name : #ViennaRuntimeUtilTest,
	#superclass : #TestCase,
	#category : 'ViennaTalk-Value-Tests'
}

{ #category : #'tests-matching-binder' }
ViennaRuntimeUtilTest >> testBinder1 [
	| matcher binder |
	matcher := '(ViennaRuntimeUtil matchIdentifier: ''x'')'.
	binder := ViennaRuntimeUtil binder: matcher with: '1' vars: #('x').
	self assert: (Compiler evaluate: '| x |' , binder , '. x') equals: 1
]

{ #category : #'tests-matching-binder' }
ViennaRuntimeUtilTest >> testBinder2 [
	| matcher binder |
	matcher := '
		(ViennaRuntimeUtil matchTuple: {
			(ViennaRuntimeUtil matchIdentifier: ''x'') . 
			(ViennaRuntimeUtil matchIdentifier: ''y'') . 
			(ViennaRuntimeUtil matchValue: 3)})'.
	binder := ViennaRuntimeUtil binder: matcher with: '#(1 2 3)' vars: #('x' 'y').
	self assert: (Compiler evaluate: '| x y |' , binder , '. {x . y}') equals: #(1 2)
]

{ #category : #'tests-matching-sequence' }
ViennaRuntimeUtilTest >> testMatchConc1 [
	self
		assert:
			((ViennaRuntimeUtil
				match: (ViennaRuntimeUtil matchSequenceEnumeration: {(ViennaRuntimeUtil matchIdentifier: 'head')})
				conc: (ViennaRuntimeUtil matchIdentifier: 'tail')) value: #(1 2 3 4) asOrderedCollection)
		equals:
			{(Dictionary new
				at: 'head' put: 1;
				at: 'tail' put: #(2 3 4) asOrderedCollection;
				yourself)}
]

{ #category : #'tests-matching-sequence' }
ViennaRuntimeUtilTest >> testMatchConc2 [
	self
		assert:
			((ViennaRuntimeUtil
				match: (ViennaRuntimeUtil matchSequenceEnumeration: {(ViennaRuntimeUtil matchIdentifier: 'head')})
				conc: (ViennaRuntimeUtil matchIdentifier: 'head')) value: #(1 2 3 4) asOrderedCollection)
		equals: {}
]

{ #category : #'tests-matching-basic' }
ViennaRuntimeUtilTest >> testMatchIdentifier [
	self
		assert: ((ViennaRuntimeUtil matchIdentifier: 'var') value: 1)
		equals:
			{(Dictionary new
				at: 'var' put: 1;
				yourself)}
]

{ #category : #'tests-matching-map' }
ViennaRuntimeUtilTest >> testMatchMapEnumeration1 [
	self
		assert:
			((ViennaRuntimeUtil
				matchMapEnumeration:
					{{(ViennaRuntimeUtil matchIdentifier: 'member').
					(ViennaRuntimeUtil matchValue: 2)}.
					{(ViennaRuntimeUtil matchValue: 2).
					(ViennaRuntimeUtil matchValue: 3)}})
				value:
					(Dictionary new
						at: 1 put: 2;
						at: 2 put: 3;
						yourself))
		equals:
			{(Dictionary new
				at: 'member' put: 1;
				yourself)}
]

{ #category : #'tests-matching-map' }
ViennaRuntimeUtilTest >> testMatchMapEnumeration2 [
	self
		assert:
			((ViennaRuntimeUtil
				matchMapEnumeration:
					{{(ViennaRuntimeUtil matchIdentifier: 'member1').
					(ViennaRuntimeUtil matchIdentifier: 'member2')}.
					{(ViennaRuntimeUtil matchIdentifier: 'member2').
					(ViennaRuntimeUtil matchValue: 3)}})
				value:
					(Dictionary new
						at: 1 put: 2;
						at: 2 put: 3;
						yourself))
		equals:
			{(Dictionary new
				at: 'member1' put: 1;
				at: 'member2' put: 2;
				yourself)}
]

{ #category : #'tests-matching-map' }
ViennaRuntimeUtilTest >> testMatchMapEnumeration3 [
	self
		assert:
			((ViennaRuntimeUtil
				matchMapEnumeration:
					{{(ViennaRuntimeUtil matchIdentifier: 'member1').
					(ViennaRuntimeUtil matchIdentifier: 'member2')}.
					{(ViennaRuntimeUtil matchIdentifier: 'member3').
					(ViennaRuntimeUtil matchIdentifier: 'member4')}})
				value:
					(Dictionary new
						at: 1 put: 2;
						at: 2 put: 3;
						yourself)) asSet
		equals:
			{(Dictionary new
				at: 'member1' put: 1;
				at: 'member2' put: 2;
				at: 'member3' put: 2;
				at: 'member4' put: 3;
				yourself).
			(Dictionary new
				at: 'member1' put: 2;
				at: 'member2' put: 3;
				at: 'member3' put: 1;
				at: 'member4' put: 2;
				yourself)} asSet
]

{ #category : #'tests-matching-map' }
ViennaRuntimeUtilTest >> testMatchMapEnumeration4 [
	self assert: ((ViennaRuntimeUtil matchMapEnumeration: {}) value: Dictionary new) equals: {(Dictionary new)}
]

{ #category : #'tests-matching-map' }
ViennaRuntimeUtilTest >> testMatchMapEnumeration5 [
	self
		assert:
			((ViennaRuntimeUtil
				matchMapEnumeration:
					{{(ViennaRuntimeUtil matchIdentifier: 'member').
					(ViennaRuntimeUtil matchValue: 2)}.
					{(ViennaRuntimeUtil matchValue: 2).
					(ViennaRuntimeUtil matchValue: 3)}})
				value:
					(Dictionary new
						at: 1 put: 1;
						at: 2 put: 3;
						yourself))
		equals: {}
]

{ #category : #'tests-matching-map' }
ViennaRuntimeUtilTest >> testMatchMapEnumeration6 [
	self
		assert:
			((ViennaRuntimeUtil
				matchMapEnumeration:
					{{(ViennaRuntimeUtil matchIdentifier: 'member').
					(ViennaRuntimeUtil matchValue: 2)}.
					{(ViennaRuntimeUtil matchValue: 2).
					(ViennaRuntimeUtil matchValue: 3)}})
				value:
					(Dictionary new
						at: 1 put: 2;
						at: 2 put: 3;
						at: 4 put: 5;
						yourself))
		equals: {}
]

{ #category : #'tests-matching-map' }
ViennaRuntimeUtilTest >> testMatchMunion1 [
	self
		assert:
			((ViennaRuntimeUtil
				match:
					(ViennaRuntimeUtil
						matchMapEnumeration:
							{{(ViennaRuntimeUtil matchIdentifier: 'key').
							(ViennaRuntimeUtil matchValue: 2)}})
				munion: (ViennaRuntimeUtil matchIdentifier: 'rest'))
				value:
					(Dictionary new
						at: 1 put: 2;
						at: 2 put: 3;
						yourself))
		equals:
			{(Dictionary new
				at: 'key' put: 1;
				at: 'rest'
					put:
						(Dictionary new
								at: 2 put: 3;
								yourself);
				yourself)}
]

{ #category : #'tests-matching-map' }
ViennaRuntimeUtilTest >> testMatchMunion2 [
	self
		assert:
			((ViennaRuntimeUtil match: (ViennaRuntimeUtil matchIdentifier: 'map1') munion: (ViennaRuntimeUtil matchIdentifier: 'map2'))
				value:
					(Dictionary new
						at: 1 put: 2;
						at: 2 put: 3;
						yourself)) asSet
		equals:
			{(Dictionary new
				at: 'map1'
					put:
						(Dictionary new
								at: 1 put: 2;
								yourself);
				at: 'map2'
					put:
						(Dictionary new
								at: 2 put: 3;
								yourself);
				yourself).
			(Dictionary new
				at: 'map1'
					put:
						(Dictionary new
								at: 2 put: 3;
								yourself);
				at: 'map2'
					put:
						(Dictionary new
								at: 1 put: 2;
								yourself);
				yourself)} asSet
]

{ #category : #'tests-matching-map' }
ViennaRuntimeUtilTest >> testMatchMunion3 [
	self
		assert:
			((ViennaRuntimeUtil
				match:
					(ViennaRuntimeUtil
						matchMapEnumeration:
							{{(ViennaRuntimeUtil matchIdentifier: 'key').
							(ViennaRuntimeUtil matchValue: 1)}})
				munion: (ViennaRuntimeUtil matchIdentifier: 'rest'))
				value:
					(Dictionary new
						at: 1 put: 2;
						at: 2 put: 3;
						yourself))
		equals: {}
]

{ #category : #'tests-matching-record' }
ViennaRuntimeUtilTest >> testMatchRecord1 [
	self
		assert:
			((ViennaRuntimeUtil
				matchRecord: 't'
				args:
					{(ViennaRuntimeUtil matchValue: 1).
					(ViennaRuntimeUtil matchIdentifier: 'field')}) value: (ViennaComposite constructorName: 't' with: 1 with: 2))
		equals:
			{(Dictionary new
				at: 'field' put: 2;
				yourself)}
]

{ #category : #'tests-matching-record' }
ViennaRuntimeUtilTest >> testMatchRecord2 [
	self
		assert:
			((ViennaRuntimeUtil
				matchRecord: 't'
				args:
					{(ViennaRuntimeUtil matchValue: 1).
					(ViennaRuntimeUtil matchIdentifier: 'field')}) value: (ViennaComposite constructorName: 't' with: 1 with: 2))
		equals:
			{(Dictionary new
				at: 'field' put: 2;
				yourself)}
]

{ #category : #'tests-matching-record' }
ViennaRuntimeUtilTest >> testMatchRecord3 [
	self
		assert:
			((ViennaRuntimeUtil
				matchRecord: 't'
				args:
					{(ViennaRuntimeUtil matchValue: 1).
					(ViennaRuntimeUtil matchValue: 2)}) value: (ViennaComposite constructorName: 't' with: 1 with: 2))
		equals: {(Dictionary new)}
]

{ #category : #'tests-matching-record' }
ViennaRuntimeUtilTest >> testMatchRecord4 [
	self
		assert:
			((ViennaRuntimeUtil
				matchRecord: 't'
				args:
					{(ViennaRuntimeUtil matchIdentifier: 'field1').
					(ViennaRuntimeUtil matchIdentifier: 'field2')}) value: (ViennaComposite constructorName: 't' with: 1 with: 2))
		equals:
			{(Dictionary new
				at: 'field1' put: 1;
				at: 'field2' put: 2;
				yourself)}
]

{ #category : #'tests-matching-record' }
ViennaRuntimeUtilTest >> testMatchRecord5 [
	self
		assert:
			((ViennaRuntimeUtil
				matchRecord: 't'
				args:
					{(ViennaRuntimeUtil matchIdentifier: 'field').
					(ViennaRuntimeUtil matchIdentifier: 'field')}) value: (ViennaComposite constructorName: 't' with: 1 with: 1))
		equals:
			{(Dictionary new
				at: 'field' put: 1;
				yourself)}
]

{ #category : #'tests-matching-record' }
ViennaRuntimeUtilTest >> testMatchRecord6 [
	self
		assert:
			((ViennaRuntimeUtil
				matchRecord: 't'
				args:
					{(ViennaRuntimeUtil matchIdentifier: 'field').
					(ViennaRuntimeUtil matchValue: 3)}) value: (ViennaComposite constructorName: 't' with: 1 with: 2))
		equals: {}
]

{ #category : #'tests-matching-record' }
ViennaRuntimeUtilTest >> testMatchRecord7 [
	self
		assert:
			((ViennaRuntimeUtil
				matchRecord: 't'
				args:
					{(ViennaRuntimeUtil matchIdentifier: 'field').
					(ViennaRuntimeUtil matchIdentifier: 'field')}) value: (ViennaComposite constructorName: 't' with: 1 with: 2))
		equals: {}
]

{ #category : #'tests-matching-record' }
ViennaRuntimeUtilTest >> testMatchRecord8 [
	self
		assert:
			((ViennaRuntimeUtil
				matchRecord: 't'
				args:
					{(ViennaRuntimeUtil matchIdentifier: 'field').
					(ViennaRuntimeUtil matchValue: 2)}) value: (ViennaComposite constructorName: 't2' with: 1 with: 2))
		equals: {}
]

{ #category : #'tests-matching-sequence' }
ViennaRuntimeUtilTest >> testMatchSequenceEnumeration1 [
	self
		assert:
			((ViennaRuntimeUtil
				matchSequenceEnumeration:
					{(ViennaRuntimeUtil matchIdentifier: 'member').
					(ViennaRuntimeUtil matchValue: 2)}) value: #(1 2) asOrderedCollection)
		equals:
			{(Dictionary new
				at: 'member' put: 1;
				yourself)}
]

{ #category : #'tests-matching-sequence' }
ViennaRuntimeUtilTest >> testMatchSequenceEnumeration2 [
	self
		assert:
			((ViennaRuntimeUtil
				matchSequenceEnumeration:
					{(ViennaRuntimeUtil matchValue: 1).
					(ViennaRuntimeUtil matchIdentifier: 'member')}) value: #(1 2) asOrderedCollection)
		equals:
			{(Dictionary new
				at: 'member' put: 2;
				yourself)}
]

{ #category : #'tests-matching-sequence' }
ViennaRuntimeUtilTest >> testMatchSequenceEnumeration3 [
	self
		assert:
			((ViennaRuntimeUtil
				matchSequenceEnumeration:
					{(ViennaRuntimeUtil matchValue: 1).
					(ViennaRuntimeUtil matchValue: 2)}) value: #(1 2) asOrderedCollection)
		equals: {(Dictionary new)}
]

{ #category : #'tests-matching-sequence' }
ViennaRuntimeUtilTest >> testMatchSequenceEnumeration4 [
	self
		assert:
			((ViennaRuntimeUtil
				matchSequenceEnumeration:
					{(ViennaRuntimeUtil matchIdentifier: 'member').
					(ViennaRuntimeUtil matchIdentifier: 'member')}) value: #(1 1) asOrderedCollection)
		equals:
			{(Dictionary new
				at: 'member' put: 1;
				yourself)}
]

{ #category : #'tests-matching-sequence' }
ViennaRuntimeUtilTest >> testMatchSequenceEnumeration5 [
	self assert: ((ViennaRuntimeUtil matchSequenceEnumeration: {}) value: #() asOrderedCollection) equals: {(Dictionary new)}
]

{ #category : #'tests-matching-sequence' }
ViennaRuntimeUtilTest >> testMatchSequenceEnumeration6 [
	self
		assert:
			((ViennaRuntimeUtil
				matchSequenceEnumeration:
					{(ViennaRuntimeUtil matchIdentifier: 'member').
					(ViennaRuntimeUtil matchValue: 2)}) value: #(1 1) asOrderedCollection)
		equals: {}
]

{ #category : #'tests-matching-sequence' }
ViennaRuntimeUtilTest >> testMatchSequenceEnumeration7 [
	self
		assert:
			((ViennaRuntimeUtil
				matchSequenceEnumeration:
					{(ViennaRuntimeUtil matchIdentifier: 'member').
					(ViennaRuntimeUtil matchValue: 2)}) value: #(1 2 3) asOrderedCollection)
		equals: {}
]

{ #category : #'tests-matching-sequence' }
ViennaRuntimeUtilTest >> testMatchSequenceEnumeration8 [
	self
		assert:
			((ViennaRuntimeUtil
				matchSequenceEnumeration:
					{(ViennaRuntimeUtil matchIdentifier: 'member').
					(ViennaRuntimeUtil matchValue: 2).
					(ViennaRuntimeUtil matchValue: 3)}) value: #(1 2) asOrderedCollection)
		equals: {}
]

{ #category : #'tests-matching-set' }
ViennaRuntimeUtilTest >> testMatchSetEnumeration1 [
	self
		assert:
			((ViennaRuntimeUtil
				matchSetEnumeration:
					{(ViennaRuntimeUtil matchIdentifier: 'member').
					(ViennaRuntimeUtil matchValue: 2)}) value: #(1 2) asSet)
		equals:
			{(Dictionary new
				at: 'member' put: 1;
				yourself)}
]

{ #category : #'tests-matching-set' }
ViennaRuntimeUtilTest >> testMatchSetEnumeration2 [
	self
		assert:
			((ViennaRuntimeUtil
				matchSetEnumeration:
					{(ViennaRuntimeUtil matchValue: 1).
					(ViennaRuntimeUtil matchIdentifier: 'member')}) value: #(1 2) asSet)
		equals:
			{(Dictionary new
				at: 'member' put: 2;
				yourself)}
]

{ #category : #'tests-matching-set' }
ViennaRuntimeUtilTest >> testMatchSetEnumeration3 [
	self
		assert:
			((ViennaRuntimeUtil
				matchSetEnumeration:
					{(ViennaRuntimeUtil matchValue: 1).
					(ViennaRuntimeUtil matchValue: 2)}) value: #(1 2) asSet)
		equals: {(Dictionary new)}
]

{ #category : #'tests-matching-set' }
ViennaRuntimeUtilTest >> testMatchSetEnumeration4 [
	self assert: ((ViennaRuntimeUtil matchSetEnumeration: {}) value: #() asSet) equals: {(Dictionary new)}
]

{ #category : #'tests-matching-set' }
ViennaRuntimeUtilTest >> testMatchSetEnumeration5 [
	self
		assert:
			((ViennaRuntimeUtil
				matchSetEnumeration:
					{(ViennaRuntimeUtil matchValue: 1).
					(ViennaRuntimeUtil matchIdentifier: 'member')}) value: #(2 1) asSet)
		equals:
			{(Dictionary new
				at: 'member' put: 2;
				yourself)}
]

{ #category : #'tests-matching-set' }
ViennaRuntimeUtilTest >> testMatchSetEnumeration6 [
	self
		assert:
			((ViennaRuntimeUtil
				matchSetEnumeration:
					{(ViennaRuntimeUtil
						matchSetEnumeration:
							{(ViennaRuntimeUtil matchIdentifier: 'member').
							(ViennaRuntimeUtil matchValue: 1)}).
					(ViennaRuntimeUtil matchIdentifier: 'member')})
				value:
					{2.
					(#(1 2) asSet)} asSet)
		equals:
			{(Dictionary new
				at: 'member' put: 2;
				yourself)}
]

{ #category : #'tests-matching-set' }
ViennaRuntimeUtilTest >> testMatchSetEnumeration7 [
	self
		assert:
			((ViennaRuntimeUtil
				matchSetEnumeration:
					{(ViennaRuntimeUtil matchIdentifier: 'member').
					(ViennaRuntimeUtil matchValue: 2)}) value: #(1 3) asSet)
		equals: {}
]

{ #category : #'tests-matching-set' }
ViennaRuntimeUtilTest >> testMatchSetEnumeration8 [
	self
		assert:
			((ViennaRuntimeUtil
				matchSetEnumeration:
					{(ViennaRuntimeUtil matchIdentifier: 'member').
					(ViennaRuntimeUtil matchValue: 2)}) value: #(1 2 3) asSet)
		equals: {}
]

{ #category : #'tests-matching-set' }
ViennaRuntimeUtilTest >> testMatchSetEnumeration9 [
	self
		assert:
			((ViennaRuntimeUtil
				matchSetEnumeration:
					{(ViennaRuntimeUtil matchIdentifier: 'member').
					(ViennaRuntimeUtil matchValue: 2).
					(ViennaRuntimeUtil matchValue: 3)}) value: #(1 2) asSet)
		equals: {}
]

{ #category : #'tests-matching-tuple' }
ViennaRuntimeUtilTest >> testMatchTuple1 [
	self
		assert:
			((ViennaRuntimeUtil
				matchTuple:
					{(ViennaRuntimeUtil matchValue: 1).
					(ViennaRuntimeUtil matchIdentifier: 'field')}) value: #(1 2))
		equals:
			{(Dictionary new
				at: 'field' put: 2;
				yourself)}
]

{ #category : #'tests-matching-tuple' }
ViennaRuntimeUtilTest >> testMatchTuple2 [
	self
		assert:
			((ViennaRuntimeUtil
				matchTuple:
					{(ViennaRuntimeUtil matchValue: 1).
					(ViennaRuntimeUtil matchIdentifier: 'field')}) value: #(1 2))
		equals:
			{(Dictionary new
				at: 'field' put: 2;
				yourself)}
]

{ #category : #'tests-matching-tuple' }
ViennaRuntimeUtilTest >> testMatchTuple3 [
	self
		assert:
			((ViennaRuntimeUtil
				matchTuple:
					{(ViennaRuntimeUtil matchValue: 1).
					(ViennaRuntimeUtil matchValue: 2)}) value: #(1 2))
		equals: {(Dictionary new)}
]

{ #category : #'tests-matching-tuple' }
ViennaRuntimeUtilTest >> testMatchTuple4 [
	self
		assert:
			((ViennaRuntimeUtil
				matchTuple:
					{(ViennaRuntimeUtil matchIdentifier: 'field1').
					(ViennaRuntimeUtil matchIdentifier: 'field2')}) value: #(1 2))
		equals:
			{(Dictionary new
				at: 'field1' put: 1;
				at: 'field2' put: 2;
				yourself)}
]

{ #category : #'tests-matching-tuple' }
ViennaRuntimeUtilTest >> testMatchTuple5 [
	self
		assert:
			((ViennaRuntimeUtil
				matchTuple:
					{(ViennaRuntimeUtil matchIdentifier: 'field').
					(ViennaRuntimeUtil matchIdentifier: 'field')}) value: #(1 1))
		equals:
			{(Dictionary new
				at: 'field' put: 1;
				yourself)}
]

{ #category : #'tests-matching-tuple' }
ViennaRuntimeUtilTest >> testMatchTuple6 [
	self
		assert:
			((ViennaRuntimeUtil
				matchTuple:
					{(ViennaRuntimeUtil matchIdentifier: 'field').
					(ViennaRuntimeUtil matchValue: 3)}) value: #(1 2))
		equals: {}
]

{ #category : #'tests-matching-set' }
ViennaRuntimeUtilTest >> testMatchUnion1 [
	self
		assert:
			((ViennaRuntimeUtil
				match:
					(ViennaRuntimeUtil
						matchSetEnumeration:
							{(ViennaRuntimeUtil matchIdentifier: 'member1').
							(ViennaRuntimeUtil matchValue: 3)})
				union:
					(ViennaRuntimeUtil
						matchSetEnumeration:
							{(ViennaRuntimeUtil matchIdentifier: 'member2').
							(ViennaRuntimeUtil matchValue: 4)})) value: #(1 2 3 4) asSet) asSet
		equals:
			{(Dictionary new
				at: 'member1' put: 1;
				at: 'member2' put: 2;
				yourself).
			(Dictionary new
				at: 'member1' put: 2;
				at: 'member2' put: 1;
				yourself)} asSet
]

{ #category : #'tests-matching-set' }
ViennaRuntimeUtilTest >> testMatchUnion2 [
	self
		assert:
			((ViennaRuntimeUtil
				match: (ViennaRuntimeUtil matchIdentifier: 'set1')
				union: (ViennaRuntimeUtil matchSetEnumeration: {(ViennaRuntimeUtil matchValue: 3)})) value: #(1 2 3 4) asSet)
		equals:
			{(Dictionary new
				at: 'set1' put: #(1 2 4) asSet;
				yourself)}
]

{ #category : #'tests-matching-set' }
ViennaRuntimeUtilTest >> testMatchUnion3 [
	self
		assert:
			((ViennaRuntimeUtil
				match: (ViennaRuntimeUtil matchIdentifier: 'set1')
				union: (ViennaRuntimeUtil matchSetEnumeration: {(ViennaRuntimeUtil matchValue: 3)})) value: #(3) asSet)
		equals: {}
]

{ #category : #'tests-matching-set' }
ViennaRuntimeUtilTest >> testMatchUnion4 [
	self
		assert:
			((ViennaRuntimeUtil
				match: (ViennaRuntimeUtil matchIdentifier: 'set1')
				union: (ViennaRuntimeUtil matchSetEnumeration: {(ViennaRuntimeUtil matchValue: 3)})) value: #(1 2 4) asSet)
		equals: {}
]

{ #category : #'tests-matching-set' }
ViennaRuntimeUtilTest >> testMatchUnion5 [
	self
		assert:
			((ViennaRuntimeUtil match: (ViennaRuntimeUtil matchIdentifier: 'set1') union: (ViennaRuntimeUtil matchIdentifier: 'set2')) value: #() asSet)
		equals: {}
]

{ #category : #'tests-matching-basic' }
ViennaRuntimeUtilTest >> testMatchValue1 [
	self assert: ((ViennaRuntimeUtil matchValue: 1) value: 1) equals: {(Dictionary new)}
]

{ #category : #'tests-matching-basic' }
ViennaRuntimeUtilTest >> testMatchValue2 [
	self assert: ((ViennaRuntimeUtil matchValue: 1) value: 2) equals: {}
]
