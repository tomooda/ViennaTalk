Class {
	#name : #ViennaUtilTest,
	#superclass : #TestCase,
	#category : 'ViennaTalk-Value-Tests'
}

{ #category : #'tests-matching-composite' }
ViennaUtilTest >> testMatchComposite1 [
	self
		assert:
			((ViennaUtil
				matchComposite: 't'
				args:
					{(ViennaUtil matchValue: 1).
					(ViennaUtil matchIdentifier: 'field')}) value: (ViennaComposite type: 't' with: 1 with: 2))
		equals:
			{(Dictionary new
				at: 'field' put: 2;
				yourself)}
]

{ #category : #'tests-matching-composite' }
ViennaUtilTest >> testMatchComposite2 [
	self
		assert:
			((ViennaUtil
				matchComposite: 't'
				args:
					{(ViennaUtil matchValue: 1).
					(ViennaUtil matchIdentifier: 'field')}) value: (ViennaComposite type: 't' with: 1 with: 2))
		equals:
			{(Dictionary new
				at: 'field' put: 2;
				yourself)}
]

{ #category : #'tests-matching-composite' }
ViennaUtilTest >> testMatchComposite3 [
	self
		assert:
			((ViennaUtil
				matchComposite: 't'
				args:
					{(ViennaUtil matchValue: 1).
					(ViennaUtil matchValue: 2)}) value: (ViennaComposite type: 't' with: 1 with: 2))
		equals: {(Dictionary new)}
]

{ #category : #'tests-matching-composite' }
ViennaUtilTest >> testMatchComposite4 [
	self
		assert:
			((ViennaUtil
				matchComposite: 't'
				args:
					{(ViennaUtil matchIdentifier: 'field1').
					(ViennaUtil matchIdentifier: 'field2')}) value: (ViennaComposite type: 't' with: 1 with: 2))
		equals:
			{(Dictionary new
				at: 'field1' put: 1;
				at: 'field2' put: 2;
				yourself)}
]

{ #category : #'tests-matching-composite' }
ViennaUtilTest >> testMatchComposite5 [
	self
		assert:
			((ViennaUtil
				matchComposite: 't'
				args:
					{(ViennaUtil matchIdentifier: 'field').
					(ViennaUtil matchIdentifier: 'field')}) value: (ViennaComposite type: 't' with: 1 with: 1))
		equals:
			{(Dictionary new
				at: 'field' put: 1;
				yourself)}
]

{ #category : #'tests-matching-composite' }
ViennaUtilTest >> testMatchComposite6 [
	self
		assert:
			((ViennaUtil
				matchComposite: 't'
				args:
					{(ViennaUtil matchIdentifier: 'field').
					(ViennaUtil matchValue: 3)}) value: (ViennaComposite type: 't' with: 1 with: 2))
		equals: {}
]

{ #category : #'tests-matching-composite' }
ViennaUtilTest >> testMatchComposite7 [
	self
		assert:
			((ViennaUtil
				matchComposite: 't'
				args:
					{(ViennaUtil matchIdentifier: 'field').
					(ViennaUtil matchIdentifier: 'field')}) value: (ViennaComposite type: 't' with: 1 with: 2))
		equals: {}
]

{ #category : #'tests-matching-composite' }
ViennaUtilTest >> testMatchComposite8 [
	self
		assert:
			((ViennaUtil
				matchComposite: 't'
				args:
					{(ViennaUtil matchIdentifier: 'field').
					(ViennaUtil matchValue: 2)}) value: (ViennaComposite type: 't2' with: 1 with: 2))
		equals: {}
]

{ #category : #'tests-matching-sequence' }
ViennaUtilTest >> testMatchConc1 [
	self
		assert:
			((ViennaUtil
				match: (ViennaUtil matchSequenceEnumeration: {(ViennaUtil matchIdentifier: 'head')})
				conc: (ViennaUtil matchIdentifier: 'tail')) value: #(1 2 3 4) asOrderedCollection)
		equals:
			{(Dictionary new
				at: 'head' put: 1;
				at: 'tail' put: #(2 3 4) asOrderedCollection;
				yourself)}
]

{ #category : #'tests-matching-sequence' }
ViennaUtilTest >> testMatchConc2 [
	self
		assert:
			((ViennaUtil
				match: (ViennaUtil matchSequenceEnumeration: {(ViennaUtil matchIdentifier: 'head')})
				conc: (ViennaUtil matchIdentifier: 'head')) value: #(1 2 3 4) asOrderedCollection)
		equals: {}
]

{ #category : #'tests-matching-basic' }
ViennaUtilTest >> testMatchIdentifier [
	self
		assert: ((ViennaUtil matchIdentifier: 'var') value: 1)
		equals:
			{(Dictionary new
				at: 'var' put: 1;
				yourself)}
]

{ #category : #'tests-matching-map' }
ViennaUtilTest >> testMatchMapEnumeration1 [
	self
		assert:
			((ViennaUtil
				matchMapEnumeration:
					{{(ViennaUtil matchIdentifier: 'member').
					(ViennaUtil matchValue: 2)}.
					{(ViennaUtil matchValue: 2).
					(ViennaUtil matchValue: 3)}})
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
ViennaUtilTest >> testMatchMapEnumeration2 [
	self
		assert:
			((ViennaUtil
				matchMapEnumeration:
					{{(ViennaUtil matchIdentifier: 'member1').
					(ViennaUtil matchIdentifier: 'member2')}.
					{(ViennaUtil matchIdentifier: 'member2').
					(ViennaUtil matchValue: 3)}})
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
ViennaUtilTest >> testMatchMapEnumeration3 [
	self
		assert:
			((ViennaUtil
				matchMapEnumeration:
					{{(ViennaUtil matchIdentifier: 'member1').
					(ViennaUtil matchIdentifier: 'member2')}.
					{(ViennaUtil matchIdentifier: 'member3').
					(ViennaUtil matchIdentifier: 'member4')}})
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
ViennaUtilTest >> testMatchMapEnumeration4 [
	self assert: ((ViennaUtil matchMapEnumeration: {}) value: Dictionary new) equals: {(Dictionary new)}
]

{ #category : #'tests-matching-map' }
ViennaUtilTest >> testMatchMapEnumeration5 [
	self
		assert:
			((ViennaUtil
				matchMapEnumeration:
					{{(ViennaUtil matchIdentifier: 'member').
					(ViennaUtil matchValue: 2)}.
					{(ViennaUtil matchValue: 2).
					(ViennaUtil matchValue: 3)}})
				value:
					(Dictionary new
						at: 1 put: 1;
						at: 2 put: 3;
						yourself))
		equals: {}
]

{ #category : #'tests-matching-map' }
ViennaUtilTest >> testMatchMapEnumeration6 [
	self
		assert:
			((ViennaUtil
				matchMapEnumeration:
					{{(ViennaUtil matchIdentifier: 'member').
					(ViennaUtil matchValue: 2)}.
					{(ViennaUtil matchValue: 2).
					(ViennaUtil matchValue: 3)}})
				value:
					(Dictionary new
						at: 1 put: 2;
						at: 2 put: 3;
						at: 4 put: 5;
						yourself))
		equals: {}
]

{ #category : #'tests-matching-map' }
ViennaUtilTest >> testMatchMunion1 [
	self
		assert:
			((ViennaUtil
				match:
					(ViennaUtil
						matchMapEnumeration:
							{{(ViennaUtil matchIdentifier: 'key').
							(ViennaUtil matchValue: 2)}})
				munion: (ViennaUtil matchIdentifier: 'rest'))
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
ViennaUtilTest >> testMatchMunion2 [
	self
		assert:
			((ViennaUtil match: (ViennaUtil matchIdentifier: 'map1') munion: (ViennaUtil matchIdentifier: 'map2'))
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
ViennaUtilTest >> testMatchMunion3 [
	self
		assert:
			((ViennaUtil
				match:
					(ViennaUtil
						matchMapEnumeration:
							{{(ViennaUtil matchIdentifier: 'key').
							(ViennaUtil matchValue: 1)}})
				munion: (ViennaUtil matchIdentifier: 'rest'))
				value:
					(Dictionary new
						at: 1 put: 2;
						at: 2 put: 3;
						yourself))
		equals: {}
]

{ #category : #'tests-matching-sequence' }
ViennaUtilTest >> testMatchSequenceEnumeration1 [
	self
		assert:
			((ViennaUtil
				matchSequenceEnumeration:
					{(ViennaUtil matchIdentifier: 'member').
					(ViennaUtil matchValue: 2)}) value: #(1 2) asOrderedCollection)
		equals:
			{(Dictionary new
				at: 'member' put: 1;
				yourself)}
]

{ #category : #'tests-matching-sequence' }
ViennaUtilTest >> testMatchSequenceEnumeration2 [
	self
		assert:
			((ViennaUtil
				matchSequenceEnumeration:
					{(ViennaUtil matchValue: 1).
					(ViennaUtil matchIdentifier: 'member')}) value: #(1 2) asOrderedCollection)
		equals:
			{(Dictionary new
				at: 'member' put: 2;
				yourself)}
]

{ #category : #'tests-matching-sequence' }
ViennaUtilTest >> testMatchSequenceEnumeration3 [
	self
		assert:
			((ViennaUtil
				matchSequenceEnumeration:
					{(ViennaUtil matchValue: 1).
					(ViennaUtil matchValue: 2)}) value: #(1 2) asOrderedCollection)
		equals: {(Dictionary new)}
]

{ #category : #'tests-matching-sequence' }
ViennaUtilTest >> testMatchSequenceEnumeration4 [
	self
		assert:
			((ViennaUtil
				matchSequenceEnumeration:
					{(ViennaUtil matchIdentifier: 'member').
					(ViennaUtil matchIdentifier: 'member')}) value: #(1 1) asOrderedCollection)
		equals:
			{(Dictionary new
				at: 'member' put: 1;
				yourself)}
]

{ #category : #'tests-matching-sequence' }
ViennaUtilTest >> testMatchSequenceEnumeration5 [
	self assert: ((ViennaUtil matchSequenceEnumeration: {}) value: #() asOrderedCollection) equals: {(Dictionary new)}
]

{ #category : #'tests-matching-sequence' }
ViennaUtilTest >> testMatchSequenceEnumeration6 [
	self
		assert:
			((ViennaUtil
				matchSequenceEnumeration:
					{(ViennaUtil matchIdentifier: 'member').
					(ViennaUtil matchValue: 2)}) value: #(1 1) asOrderedCollection)
		equals: {}
]

{ #category : #'tests-matching-sequence' }
ViennaUtilTest >> testMatchSequenceEnumeration7 [
	self
		assert:
			((ViennaUtil
				matchSequenceEnumeration:
					{(ViennaUtil matchIdentifier: 'member').
					(ViennaUtil matchValue: 2)}) value: #(1 2 3) asOrderedCollection)
		equals: {}
]

{ #category : #'tests-matching-sequence' }
ViennaUtilTest >> testMatchSequenceEnumeration8 [
	self
		assert:
			((ViennaUtil
				matchSequenceEnumeration:
					{(ViennaUtil matchIdentifier: 'member').
					(ViennaUtil matchValue: 2).
					(ViennaUtil matchValue: 3)}) value: #(1 2) asOrderedCollection)
		equals: {}
]

{ #category : #'tests-matching-set' }
ViennaUtilTest >> testMatchSetEnumeration1 [
	self
		assert:
			((ViennaUtil
				matchSetEnumeration:
					{(ViennaUtil matchIdentifier: 'member').
					(ViennaUtil matchValue: 2)}) value: #(1 2) asSet)
		equals:
			{(Dictionary new
				at: 'member' put: 1;
				yourself)}
]

{ #category : #'tests-matching-set' }
ViennaUtilTest >> testMatchSetEnumeration2 [
	self
		assert:
			((ViennaUtil
				matchSetEnumeration:
					{(ViennaUtil matchValue: 1).
					(ViennaUtil matchIdentifier: 'member')}) value: #(1 2) asSet)
		equals:
			{(Dictionary new
				at: 'member' put: 2;
				yourself)}
]

{ #category : #'tests-matching-set' }
ViennaUtilTest >> testMatchSetEnumeration3 [
	self
		assert:
			((ViennaUtil
				matchSetEnumeration:
					{(ViennaUtil matchValue: 1).
					(ViennaUtil matchValue: 2)}) value: #(1 2) asSet)
		equals: {(Dictionary new)}
]

{ #category : #'tests-matching-set' }
ViennaUtilTest >> testMatchSetEnumeration4 [
	self assert: ((ViennaUtil matchSetEnumeration: {}) value: #() asSet) equals: {(Dictionary new)}
]

{ #category : #'tests-matching-set' }
ViennaUtilTest >> testMatchSetEnumeration5 [
	self
		assert:
			((ViennaUtil
				matchSetEnumeration:
					{(ViennaUtil matchValue: 1).
					(ViennaUtil matchIdentifier: 'member')}) value: #(2 1) asSet)
		equals:
			{(Dictionary new
				at: 'member' put: 2;
				yourself)}
]

{ #category : #'tests-matching-set' }
ViennaUtilTest >> testMatchSetEnumeration6 [
	self
		assert:
			((ViennaUtil
				matchSetEnumeration:
					{(ViennaUtil
						matchSetEnumeration:
							{(ViennaUtil matchIdentifier: 'member').
							(ViennaUtil matchValue: 1)}).
					(ViennaUtil matchIdentifier: 'member')})
				value:
					{2.
					(#(1 2) asSet)} asSet)
		equals:
			{(Dictionary new
				at: 'member' put: 2;
				yourself)}
]

{ #category : #'tests-matching-set' }
ViennaUtilTest >> testMatchSetEnumeration7 [
	self
		assert:
			((ViennaUtil
				matchSetEnumeration:
					{(ViennaUtil matchIdentifier: 'member').
					(ViennaUtil matchValue: 2)}) value: #(1 3) asSet)
		equals: {}
]

{ #category : #'tests-matching-set' }
ViennaUtilTest >> testMatchSetEnumeration8 [
	self
		assert:
			((ViennaUtil
				matchSetEnumeration:
					{(ViennaUtil matchIdentifier: 'member').
					(ViennaUtil matchValue: 2)}) value: #(1 2 3) asSet)
		equals: {}
]

{ #category : #'tests-matching-set' }
ViennaUtilTest >> testMatchSetEnumeration9 [
	self
		assert:
			((ViennaUtil
				matchSetEnumeration:
					{(ViennaUtil matchIdentifier: 'member').
					(ViennaUtil matchValue: 2).
					(ViennaUtil matchValue: 3)}) value: #(1 2) asSet)
		equals: {}
]

{ #category : #'tests-matching-tuple' }
ViennaUtilTest >> testMatchTuple1 [
	self
		assert:
			((ViennaUtil
				matchTuple:
					{(ViennaUtil matchValue: 1).
					(ViennaUtil matchIdentifier: 'field')}) value: #(1 2))
		equals:
			{(Dictionary new
				at: 'field' put: 2;
				yourself)}
]

{ #category : #'tests-matching-tuple' }
ViennaUtilTest >> testMatchTuple2 [
	self
		assert:
			((ViennaUtil
				matchTuple:
					{(ViennaUtil matchValue: 1).
					(ViennaUtil matchIdentifier: 'field')}) value: #(1 2))
		equals:
			{(Dictionary new
				at: 'field' put: 2;
				yourself)}
]

{ #category : #'tests-matching-tuple' }
ViennaUtilTest >> testMatchTuple3 [
	self
		assert:
			((ViennaUtil
				matchTuple:
					{(ViennaUtil matchValue: 1).
					(ViennaUtil matchValue: 2)}) value: #(1 2))
		equals: {(Dictionary new)}
]

{ #category : #'tests-matching-tuple' }
ViennaUtilTest >> testMatchTuple4 [
	self
		assert:
			((ViennaUtil
				matchTuple:
					{(ViennaUtil matchIdentifier: 'field1').
					(ViennaUtil matchIdentifier: 'field2')}) value: #(1 2))
		equals:
			{(Dictionary new
				at: 'field1' put: 1;
				at: 'field2' put: 2;
				yourself)}
]

{ #category : #'tests-matching-tuple' }
ViennaUtilTest >> testMatchTuple5 [
	self
		assert:
			((ViennaUtil
				matchTuple:
					{(ViennaUtil matchIdentifier: 'field').
					(ViennaUtil matchIdentifier: 'field')}) value: #(1 1))
		equals:
			{(Dictionary new
				at: 'field' put: 1;
				yourself)}
]

{ #category : #'tests-matching-tuple' }
ViennaUtilTest >> testMatchTuple6 [
	self
		assert:
			((ViennaUtil
				matchTuple:
					{(ViennaUtil matchIdentifier: 'field').
					(ViennaUtil matchValue: 3)}) value: #(1 2))
		equals: {}
]

{ #category : #'tests-matching-set' }
ViennaUtilTest >> testMatchUnion1 [
	self
		assert:
			((ViennaUtil
				match:
					(ViennaUtil
						matchSetEnumeration:
							{(ViennaUtil matchIdentifier: 'member1').
							(ViennaUtil matchValue: 3)})
				union:
					(ViennaUtil
						matchSetEnumeration:
							{(ViennaUtil matchIdentifier: 'member2').
							(ViennaUtil matchValue: 4)})) value: #(1 2 3 4) asSet) asSet
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
ViennaUtilTest >> testMatchUnion2 [
	self
		assert:
			((ViennaUtil
				match: (ViennaUtil matchIdentifier: 'set1')
				union: (ViennaUtil matchSetEnumeration: {(ViennaUtil matchValue: 3)})) value: #(1 2 3 4) asSet)
		equals:
			{(Dictionary new
				at: 'set1' put: #(1 2 4) asSet;
				yourself)}
]

{ #category : #'tests-matching-set' }
ViennaUtilTest >> testMatchUnion3 [
	self
		assert:
			((ViennaUtil
				match: (ViennaUtil matchIdentifier: 'set1')
				union: (ViennaUtil matchSetEnumeration: {(ViennaUtil matchValue: 3)})) value: #(3) asSet)
		equals: {}
]

{ #category : #'tests-matching-set' }
ViennaUtilTest >> testMatchUnion4 [
	self
		assert:
			((ViennaUtil
				match: (ViennaUtil matchIdentifier: 'set1')
				union: (ViennaUtil matchSetEnumeration: {(ViennaUtil matchValue: 3)})) value: #(1 2 4) asSet)
		equals: {}
]

{ #category : #'tests-matching-set' }
ViennaUtilTest >> testMatchUnion5 [
	self
		assert:
			((ViennaUtil match: (ViennaUtil matchIdentifier: 'set1') union: (ViennaUtil matchIdentifier: 'set2')) value: #() asSet)
		equals: {}
]

{ #category : #'tests-matching-basic' }
ViennaUtilTest >> testMatchValue1 [
	self assert: ((ViennaUtil matchValue: 1) value: 1) equals: {(Dictionary new)}
]

{ #category : #'tests-matching-basic' }
ViennaUtilTest >> testMatchValue2 [
	self assert: ((ViennaUtil matchValue: 1) value: 2) equals: {}
]
