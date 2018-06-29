Class {
	#name : #ViennaCompositeTypeTest,
	#superclass : #TestCase,
	#instVars : [
		'composite'
	],
	#category : 'ViennaTalk-Type-Tests'
}

{ #category : #running }
ViennaCompositeTypeTest >> setUp [
	super setUp.
	composite := ViennaCompositeType
		constructorName: 'T'
		withAll:
			{{nil.
			false.
			(ViennaType int)}.
			{'f2'.
			true.
			(ViennaType nat)}.
			{'f3'.
			false.
			(ViennaType quote: '<QUOTE>')}}
]

{ #category : #tests }
ViennaCompositeTypeTest >> testBaseTypeAt [
	self assert: (composite basetypeAt: 1) equals: ViennaType int
]

{ #category : #tests }
ViennaCompositeTypeTest >> testDo [
	self should: [ composite do: [ :v |  ] ] raise: ShouldNotImplement.
	self
		assert:
			(Array
				new: 6
				streamContents: [ :stream | 
					(ViennaCompositeType
						constructorName: 'T'
						withAll:
							(#(#('<ONE>') #('<TWO>' '<THREE>') #('<FOUR>' '<FIVE>' '<SIX>'))
								collect: [ :array | 
									{nil.
									false.
									(ViennaType union: (array collect: [ :string | ViennaType quote: string ]))} ]))
						do: [ :record | stream nextPut: ((1 to: 3) collect: [ :i | record at: i ]) ] ]) asSet
		equals:
			#(#(#'<ONE>' #'<TWO>' #'<FOUR>') #(#'<ONE>' #'<TWO>' #'<FIVE>') #(#'<ONE>' #'<TWO>' #'<SIX>') #(#'<ONE>' #'<THREE>' #'<FOUR>') #(#'<ONE>' #'<THREE>' #'<FIVE>') #(#'<ONE>' #'<THREE>' #'<SIX>'))
				asSet
]

{ #category : #tests }
ViennaCompositeTypeTest >> testIncludes [
	self
		assert:
			(composite
				includes:
					(ViennaComposite
						constructorName: 'T'
						with: -1
						with: 1
						with: #'<QUOTE>')).
	self deny: (composite includes: 1)
]

{ #category : #tests }
ViennaCompositeTypeTest >> testIsEnumerable [
	self deny: composite isEnumerable.
	self
		assert:
			(ViennaCompositeType
				constructorName: 'T'
				withAll:
					(#(#('<ONE>') #('<TWO>' '<THREE>') #('<FOUR>' '<FIVE>' '<SIX>'))
						collect: [ :array | 
							{nil.
							false.
							(ViennaType union: (array collect: [ :string | ViennaType quote: string ]))} ])) isEnumerable
]

{ #category : #tests }
ViennaCompositeTypeTest >> testName [
	self assert: composite name equals: 'compose T of int f2:-nat f3:<QUOTE> end'
]

{ #category : #tests }
ViennaCompositeTypeTest >> testNumFields [
	self assert: composite numFields equals: 3
]

{ #category : #tests }
ViennaCompositeTypeTest >> testSubset [
	self assert: composite <= composite.
	self deny: composite <= ViennaType int
]

{ #category : #tests }
ViennaCompositeTypeTest >> testValueWithArguments [
	(composite valueWithArguments: #(-1 1 #'<QUOTE>'))
		in: [ :record | 
			self assert: (record at: 1) equals: -1.
			self assert: (record at: 2) equals: 1.
			self assert: (record at: 'f2') equals: 1.
			self assert: (record at: 3) equals: #'<QUOTE>'.
			self assert: (record at: 'f3') equals: #'<QUOTE>'.
			self assert: record equals: (composite valueWithArguments: #(-1 1 #'<QUOTE>')).
			self assert: record equals: (composite valueWithArguments: #(-1 0 #'<QUOTE>')).
			self deny: record = (composite valueWithArguments: #(1 1 #'<QUOTE>')) ]
]
