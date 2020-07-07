Class {
	#name : #ViennaVDMJTest,
	#superclass : #TestCase,
	#instVars : [
		'process'
	],
	#category : #'ViennaTalk-Engine-Tests'
}

{ #category : #running }
ViennaVDMJTest >> setUp [
	process := ViennaVDMJ new
]

{ #category : #running }
ViennaVDMJTest >> shutDown [
	process ifNotNil: [process close].
	process := nil
]

{ #category : #private }
ViennaVDMJTest >> stateFromArray: anArray [
	| state |
	state := Dictionary new: anArray size.
	anArray
		do: [ :moduleAndBinds | 
			| binds |
			binds := Dictionary new: moduleAndBinds value size.
			state at: moduleAndBinds key put: binds.
			moduleAndBinds value do: [ :assoc | binds add: assoc ] ].
	^ state
]

{ #category : #'testing-empty' }
ViennaVDMJTest >> test0 [
	self
		testExpression: ''
		specification: ''
		states: Dictionary new
		resultValue: ''
		resultStates: Dictionary new
]

{ #category : #'testing-only expression' }
ViennaVDMJTest >> test1InvalidExpression [
	self
		testExpression: ' 1 +  '
		specification: ''
		states: Dictionary new
		resultValue: nil
		resultStates: Dictionary new
]

{ #category : #'testing-only specification' }
ViennaVDMJTest >> test1InvalidSpecification [
	self
		testExpression: ''
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := count + "1"; return count);'
		states: Dictionary new
		resultValue: nil
		resultStates: (Dictionary new)
]

{ #category : #'testing-only states' }
ViennaVDMJTest >> test1InvalidStates [
	self
		testExpression: ''
		specification: ''
		states: (self stateFromArray: {'DEFAULT' -> {'frq' -> '441frq'}})
		resultValue: ''
		resultStates: Dictionary new.
	self
		testExpression: ''
		specification: ''
		states: (self stateFromArray: {'DEFAULT' -> {'frq' -> '4+"41"'}})
		resultValue: ''
		resultStates: Dictionary new
]

{ #category : #'testing-only expression' }
ViennaVDMJTest >> test1TypeErrorExpression [
	self
		testExpression: ' 1 +  "2"'
		specification: ''
		states: Dictionary new
		resultValue: nil
		resultStates: Dictionary new
]

{ #category : #'testing-only expression' }
ViennaVDMJTest >> test1ValidExpression [
	self
		testExpression: ' 1 + 2 '
		specification: ''
		states: Dictionary new
		resultValue: '3'
		resultStates: Dictionary new
]

{ #category : #'testing-only specification' }
ViennaVDMJTest >> test1ValidSpecification [
	self
		testExpression: ''
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := count + 1; return count);'
		states: Dictionary new
		resultValue: ''
		resultStates: (self stateFromArray: {'DEFAULT' -> {'count' -> '0'}})
]

{ #category : #'testing-only states' }
ViennaVDMJTest >> test1ValidStates [
	self
		testExpression: ''
		specification: ''
		states: (self stateFromArray: {'DEFAULT' -> { 'frq' -> '441'} })
		resultValue: ''
		resultStates: Dictionary new
]

{ #category : #'testing-expression and specification' }
ViennaVDMJTest >> test2InvalidExpressionAndInvalidSpecification [
	self
		testExpression: '1+'
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := frq + 1; return count);'
		states: Dictionary new
		resultValue: nil
		resultStates: Dictionary new
]

{ #category : #'testing-expression and state' }
ViennaVDMJTest >> test2InvalidExpressionAndInvalidState [
	self
		testExpression: '1+'
		specification: ''
		states: (self stateFromArray: {'DEFAULT' -> {'count' -> 'frq'}})
		resultValue: nil
		resultStates: (self stateFromArray: {'DEFAULT' -> {'count' -> 'frq'}})
]

{ #category : #'testing-expression and specification' }
ViennaVDMJTest >> test2InvalidExpressionAndValidSpecification [
	self
		testExpression: '1+"2"'
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := count + 1; return count);'
		states: Dictionary new
		resultValue: nil
		resultStates: Dictionary new
]

{ #category : #'testing-expression and state' }
ViennaVDMJTest >> test2InvalidExpressionAndValidState [
	self
		testExpression: '1+'
		specification: ''
		states: (self stateFromArray: {'DEFAULT' -> {'count' -> '0'}})
		resultValue: nil
		resultStates: (self stateFromArray: {'DEFAULT' -> {'count' -> '0'}})
]

{ #category : #'testing-specification and state' }
ViennaVDMJTest >> test2InvalidSpecificationAndInvalidState [
	self
		testExpression: ''
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := frq + 1; return count);'
		states: (self stateFromArray: {'DEFAULT' -> {'frq' -> 'frq+"441"'}})
		resultValue: nil
		resultStates: (self stateFromArray: {'DEFAULT' -> {'frq' -> 'frq+"441"'}}).
	self
		testExpression: ''
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := frq + 1; return count);'
		states: (self stateFromArray: {'DEFAULT' -> {'frq' -> '441'}})
		resultValue: nil
		resultStates: (self stateFromArray: {'DEFAULT' -> {'frq' -> '441'}})
]

{ #category : #'testing-specification and state' }
ViennaVDMJTest >> test2InvalidSpecificationAndValidState [
	self
		testExpression: ''
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := frq + 1; return count);'
		states: (self stateFromArray: {'DEFAULT' -> {'frq' -> '0'}})
		resultValue: nil
		resultStates: (self stateFromArray: {'DEFAULT' -> {'frq' -> '0'}}).
	self
		testExpression: ''
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := frq + 1; return count);'
		states: (self stateFromArray: {'DEFAULT' -> {'count' -> '441'}})
		resultValue: nil
		resultStates: (self stateFromArray: {'DEFAULT' -> {'count' -> '441'}})
]

{ #category : #'testing-expression and specification' }
ViennaVDMJTest >> test2ValidExpressionAndInvalidSpecification [
	self
		testExpression: '1+2'
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := frq + 1; return count);'
		states: Dictionary new
		resultValue: nil
		resultStates: Dictionary new
]

{ #category : #'testing-expression and state' }
ViennaVDMJTest >> test2ValidExpressionAndInvalidState [
	self
		testExpression: '1+2'
		specification: ''
		states: (self stateFromArray: {'DEFAULT' -> {'count' -> 'frq'}})
		resultValue: '3'
		resultStates: Dictionary new
]

{ #category : #'testing-expression and specification' }
ViennaVDMJTest >> test2ValidExpressionAndValidSpecification [
	self
		testExpression: '1+2'
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := count + 1; return count);'
		states: Dictionary new
		resultValue: '3'
		resultStates: (self stateFromArray: {'DEFAULT' -> {'count' -> '0'}})
]

{ #category : #'testing-expression and state' }
ViennaVDMJTest >> test2ValidExpressionAndValidState [
	self
		testExpression: '1+2'
		specification: ''
		states: (self stateFromArray: {'DEFAULT' -> {'count' -> '0'}})
		resultValue: '3'
		resultStates: Dictionary new
]

{ #category : #'testing-specification and state' }
ViennaVDMJTest >> test2ValidSpecificationAndInvalidState [
	self
		testExpression: ''
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := count + 1; return count);'
		states: (self stateFromArray: {'DEFAULT' -> {'count' -> 'frq'}})
		resultValue: nil
		resultStates: (self stateFromArray: {'DEFAULT' -> {'count' -> 'frq'}}).
	self
		testExpression: ''
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := count + 1; return count);'
		states: (self stateFromArray: {'DEFAULT' -> {'frq' -> '441'}})
		resultValue: ''
		resultStates: (self stateFromArray: {'DEFAULT' -> {'count' -> '0'}})
]

{ #category : #'testing-specification and state' }
ViennaVDMJTest >> test2ValidSpecificationAndValidState [
	self
		testExpression: ''
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := count + 1; return count);'
		states: (self stateFromArray: {'DEFAULT' -> {'frq' -> '0'}})
		resultValue: ''
		resultStates: (self stateFromArray: {'DEFAULT' -> {'count' -> '0'}}).
	self
		testExpression: ''
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := count + 1; return count);'
		states: (self stateFromArray: {'DEFAULT' -> {'count' -> '441'}})
		resultValue: ''
		resultStates: (self stateFromArray: {'DEFAULT' -> {'count' -> '441'}})
]

{ #category : #'testing-all' }
ViennaVDMJTest >> test3InvalidExpressionAndInvalidSpecificationAndInvalidState [
	self
		testExpression: ' inc ( 3 ) '
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := frq + 1; return count);'
		states: (self stateFromArray: {'DEFAULT' -> {'frq' -> '0+"0"'}})
		resultValue: nil
		resultStates: (self stateFromArray: {'DEFAULT' -> {'frq' -> '0+"0"'}}).
	self
		testExpression: ' inc ( 3 ) '
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := frq + 1; return count);'
		states: (self stateFromArray: {'DEFAULT' -> {'count' -> '4+"41"'}})
		resultValue: nil
		resultStates: (self stateFromArray: {'DEFAULT' -> {'count' -> '4+"41"'}})
]

{ #category : #'testing-all' }
ViennaVDMJTest >> test3InvalidExpressionAndInvalidSpecificationAndValidState [
	self
		testExpression: ' inc ( 3 ) '
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := frq + 1; return count);'
		states: (self stateFromArray: {'DEFAULT' -> {'frq' -> '0'}})
		resultValue: nil
		resultStates: (self stateFromArray: {'DEFAULT' -> {'frq' -> '0'}}).
	self
		testExpression: ' inc ( 3 ) '
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := frq + 1; return count);'
		states: (self stateFromArray: {'DEFAULT' -> {'count' -> '441'}})
		resultValue: nil
		resultStates: (self stateFromArray: {'DEFAULT' -> {'count' -> '441'}})
]

{ #category : #'testing-all' }
ViennaVDMJTest >> test3InvalidExpressionAndValidSpecificationAndInvalidState [
	self
		testExpression: ' inc ( 3 ) '
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := count + 1; return count);'
		states: (self stateFromArray: {'DEFAULT' -> {'frq' -> '0+"0"'}})
		resultValue: nil
		resultStates: (self stateFromArray: {'DEFAULT' -> {'frq' -> '0+"0"'}}).
	self
		testExpression: ' inc ( 3 ) '
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := count + 1; return count);'
		states: (self stateFromArray: {'DEFAULT' -> {'count' -> '4+"41"'}})
		resultValue: nil
		resultStates: (self stateFromArray: {'DEFAULT' -> {'count' -> '4+"41"'}})
]

{ #category : #'testing-all' }
ViennaVDMJTest >> test3InvalidExpressionAndValidSpecificationAndValidState [
	self
		testExpression: ' inc ( 3 ) '
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := count + 1; return count);'
		states: (self stateFromArray: {'DEFAULT' -> {'frq' -> '0'}})
		resultValue: nil
		resultStates: (self stateFromArray: {'DEFAULT' -> {'frq' -> '0'}}).
	self
		testExpression: ' inc ( 3 ) '
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := count + 1; return count);'
		states: (self stateFromArray: {'DEFAULT' -> {'count' -> '441'}})
		resultValue: nil
		resultStates: (self stateFromArray: {'DEFAULT' -> {'count' -> '441'}})
]

{ #category : #'testing-all' }
ViennaVDMJTest >> test3ValidExpressionAndInvalidSpecificationAndInvalidState [
	self
		testExpression: ' inc ( ) '
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := frq + 1; return count);'
		states: (self stateFromArray: {'DEFAULT' -> {'frq' -> '4+"41"'}})
		resultValue: nil
		resultStates: (self stateFromArray: {'DEFAULT' -> {'frq' -> '4+"41"'}}).
	self
		testExpression: ' inc ( ) '
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := frq + 1; return count);'
		states: (self stateFromArray: {'DEFAULT' -> {'count' -> '4+"41"'}})
		resultValue: nil
		resultStates: (self stateFromArray: {'DEFAULT' -> {'count' -> '4+"41"'}})
]

{ #category : #'testing-all' }
ViennaVDMJTest >> test3ValidExpressionAndInvalidSpecificationAndValidState [
	self
		testExpression: ' inc ( ) '
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := frq + 1; return count);'
		states: (self stateFromArray: {'DEFAULT' -> {'frq' -> '0'}})
		resultValue: nil
		resultStates: (self stateFromArray: {'DEFAULT' -> {'frq' -> '0'}}).
	self
		testExpression: ' inc ( ) '
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := frq + 1; return count);'
		states: (self stateFromArray: {'DEFAULT' -> {'count' -> '441'}})
		resultValue: nil
		resultStates: (self stateFromArray: {'DEFAULT' -> {'count' -> '441'}})
]

{ #category : #'testing-all' }
ViennaVDMJTest >> test3ValidExpressionAndValidSpecificationAndInvalidState [
	self
		testExpression: ' inc ( ) '
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := count + 1; return count);'
		states: (self stateFromArray: {'DEFAULT' -> {'frq' -> '0'}})
		resultValue: '1'
		resultStates: (self stateFromArray: {'DEFAULT' -> {'count' -> '1'}}).
	self
		testExpression: ' inc ( ) '
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := count + 1; return count);'
		states: (self stateFromArray: {'DEFAULT' -> {'count' -> '4+"41"'}})
		resultValue: nil
		resultStates: (self stateFromArray: {'DEFAULT' -> {'count' -> '4+"41"'}})
]

{ #category : #'testing-all' }
ViennaVDMJTest >> test3ValidExpressionAndValidSpecificationAndValidState [
	self
		testExpression: ' inc ( ) '
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := count + 1; return count);'
		states: (self stateFromArray: {'DEFAULT' -> {'frq' -> '0'}})
		resultValue: '1'
		resultStates: (self stateFromArray: {'DEFAULT' -> {'count' -> '1'}}).
	self
		testExpression: ' inc ( ) '
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := count + 1; return count);'
		states: (self stateFromArray: {'DEFAULT' -> {'count' -> '441'}})
		resultValue: '442'
		resultStates: (self stateFromArray: {'DEFAULT' -> {'count' -> '442'}})
]

{ #category : #testing }
ViennaVDMJTest >> testExpression: expression specification: specification states: states resultValue: resultValue resultStates: resultStates [ 
	(process
		evaluate: expression
		specification: specification
		states: states
		vdm10: true
		rtc: true)
		in: [:triple | 
			self assert: resultValue equals: triple first.
			self assert: resultStates equals: triple second.
			self assert: resultValue isNil equals: triple third notEmpty]
]
