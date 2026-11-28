Class {
	#name : 'VDMPadWorkerPoolTest',
	#superclass : 'TestCase',
	#instVars : [
		'worker'
	],
	#category : 'ViennaTalk-VDMPad-Core-Tests',
	#package : 'ViennaTalk-VDMPad-Core',
	#tag : 'Tests'
}

{ #category : 'sources' }
VDMPadWorkerPoolTest >> flatCounterSpec [

	^ 'state Counter of
	count : nat
init s == s = mk_Counter(0)
end
operations
click : () ==> ()
click() == count := count + 1;
show : () ==> nat
show() == return count;'
]

{ #category : 'sources' }
VDMPadWorkerPoolTest >> modularCounterSpec [

	^ String streamContents: [ :stream |
			  stream
				  nextPutAll: 'module Counter
exports all
definitions';
				  cr;
				  nextPutAll: self flatCounterSpec;
				  cr;
				  nextPutAll: 'end Counter' ]
]

{ #category : 'running' }
VDMPadWorkerPoolTest >> setUp [

	super setUp.
	worker := VDMPadWorkerPool new
]

{ #category : 'tests' }
VDMPadWorkerPoolTest >> testFlatSpecNilModule [

	| result |
	result := worker
		          evaluate: '(click(); return show())'
		          specification: self flatCounterSpec
		          states: {
				          ('DEFAULT' -> {
					           ('foo' -> '<FOO>').
					           ('count' -> '10') } asDictionary).
				          ('Nowhere' -> { ('quuux' -> '<QUUUX>') }) } asDictionary
		          module: nil
		          diagrams: #( 'sequenceDiagram' 'stateDiagram' ).
	self assert: (worker valueFromResult: result) equals: '11'.
	self assert: (worker prestatesFromResult: result) equals: { ('DEFAULT' -> { ('count' -> '10') } asDictionary) } asDictionary.
	self assert: (worker poststatesFromResult: result) equals: { ('DEFAULT' -> { ('count' -> '11') } asDictionary) } asDictionary.
	self assert: (worker messageFromResult: result) equals: nil.
	self
		assert: (worker
				 diagram: 'sequenceDiagram'
				 fromResult: result
				 ifPresent: [ true ]
				 ifAbsent: [ false ])
		equals: true.
	self
		assert: (worker
				 diagram: 'stateDiagram'
				 fromResult: result
				 ifPresent: [ true ]
				 ifAbsent: [ false ])
		equals: true
]

{ #category : 'tests' }
VDMPadWorkerPoolTest >> testFlatSpecWrongModule [

	| result |
	result := worker
		          evaluate: '(click(); return show())'
		          specification: self flatCounterSpec
		          states: {
				          ('DEFAULT' -> {
					           ('foo' -> '<FOO>').
					           ('count' -> '10') } asDictionary).
				          ('Nowhere' -> {
					           ('bar' -> '<BAR>').
					           ('quuux' -> '<QUUUX>') } asDictionary) } asDictionary
		          module: 'Nowhere'
		          diagrams: #( 'sequenceDiagram' 'stateDiagram' ).
	self assert: (worker valueFromResult: result) equals: nil.
	self assert: (worker prestatesFromResult: result) equals: { ('DEFAULT' -> { ('count' -> '10') } asDictionary) } asDictionary.
	self assert: (worker poststatesFromResult: result) equals: { ('DEFAULT' -> { ('count' -> '10') } asDictionary) } asDictionary.
	self assert: (worker messageFromResult: result) notNil
]

{ #category : 'tests' }
VDMPadWorkerPoolTest >> testModularSpecNilModule [

	| result |
	result := worker
		          evaluate: '(Counter`click(); return Counter`show())'
		          specification: self modularCounterSpec
		          states: {
				          ('Counter' -> {
					           ('foo' -> '<FOO>').
					           ('count' -> '10') } asDictionary).
				          ('Nowhere' -> { ('quuux' -> '<QUUUX>') }) } asDictionary
		          module: nil
		          diagrams: #( 'sequenceDiagram' 'stateDiagram' ).
	self assert: (worker valueFromResult: result) equals: '11'.
	self assert: (worker prestatesFromResult: result) equals: { ('Counter' -> { ('count' -> '10') } asDictionary) } asDictionary.
	self assert: (worker poststatesFromResult: result) equals: { ('Counter' -> { ('count' -> '11') } asDictionary) } asDictionary.
	self assert: (worker messageFromResult: result) equals: nil.
	self
		assert: (worker
				 diagram: 'sequenceDiagram'
				 fromResult: result
				 ifPresent: [ true ]
				 ifAbsent: [ false ])
		equals: true.
	self
		assert: (worker
				 diagram: 'stateDiagram'
				 fromResult: result
				 ifPresent: [ true ]
				 ifAbsent: [ false ])
		equals: true
]

{ #category : 'tests' }
VDMPadWorkerPoolTest >> testModularSpecRightModule [

	| result |
	result := worker
		          evaluate: '(click(); return show())'
		          specification: self modularCounterSpec
		          states: {
				          ('Counter' -> {
					           ('foo' -> '<FOO>').
					           ('count' -> '10') } asDictionary).
				          ('Nowhere' -> { ('quuux' -> '<QUUUX>') }) } asDictionary
		          module: 'Counter'
		          diagrams: #( 'sequenceDiagram' 'stateDiagram' ).
	self assert: (worker valueFromResult: result) equals: '11'.
	self assert: (worker prestatesFromResult: result) equals: { ('Counter' -> { ('count' -> '10') } asDictionary) } asDictionary.
	self assert: (worker poststatesFromResult: result) equals: { ('Counter' -> { ('count' -> '11') } asDictionary) } asDictionary.
	self assert: (worker messageFromResult: result) equals: nil.
	self
		assert: (worker
				 diagram: 'sequenceDiagram'
				 fromResult: result
				 ifPresent: [ true ]
				 ifAbsent: [ false ])
		equals: true.
	self
		assert: (worker
				 diagram: 'stateDiagram'
				 fromResult: result
				 ifPresent: [ true ]
				 ifAbsent: [ false ])
		equals: true
]

{ #category : 'tests' }
VDMPadWorkerPoolTest >> testModularSpecWrongModule [

	| result |
	result := worker
		          evaluate: '(click(); return show())'
		          specification: self modularCounterSpec
		          states: {
				          ('Counter' -> {
					           ('foo' -> '<FOO>').
					           ('count' -> '10') } asDictionary).
				          ('Nowhere' -> { ('quuux' -> '<QUUUX>') }) } asDictionary
		          module: 'Nowhere'
		          diagrams: #( 'sequenceDiagram' 'stateDiagram' ).
	self assert: (worker valueFromResult: result) equals: nil.
	self assert: (worker prestatesFromResult: result) equals: { ('Counter' -> { ('count' -> '10') } asDictionary) } asDictionary.
	self assert: (worker poststatesFromResult: result) equals: { ('Counter' -> { ('count' -> '10') } asDictionary) } asDictionary.
	self assert: (worker messageFromResult: result) isString
]

{ #category : 'tests' }
VDMPadWorkerPoolTest >> testNoSpecBothDiagram [

	| result |
	result := worker
		          evaluate: '''b'' in set elems "abc"'
		          specification: ''
		          states: Dictionary new
		          module: nil
		          diagrams: #( 'sequenceDiagram' 'stateDiagram' ).
	self assert: (worker valueFromResult: result) equals: true viennaString.
	self assert: (worker prestatesFromResult: result) equals: Dictionary new.
	self assert: (worker poststatesFromResult: result) equals: Dictionary new.
	self assert: (worker messageFromResult: result) equals: nil.
	self
		assert: (worker
				 diagram: 'sequenceDiagram'
				 fromResult: result
				 ifPresent: [ true ]
				 ifAbsent: [ false ])
		equals: true.
	self
		assert: (worker
				 diagram: 'stateDiagram'
				 fromResult: result
				 ifPresent: [ true ]
				 ifAbsent: [ false ])
		equals: true
]

{ #category : 'tests' }
VDMPadWorkerPoolTest >> testNoSpecNoDiagram [

	| result |
	result := worker
		          evaluate: '''b'' in set elems "abc"'
		          specification: ''
		          states: Dictionary new
		          module: nil
		          diagrams: #(  ).
	self assert: (worker valueFromResult: result) equals: true viennaString.
	self assert: (worker prestatesFromResult: result) equals: Dictionary new.
	self assert: (worker poststatesFromResult: result) equals: Dictionary new.
	self assert: (worker messageFromResult: result) equals: nil
]

{ #category : 'tests' }
VDMPadWorkerPoolTest >> testNoSpecSequenceDiagram [

	| result |
	result := worker
		          evaluate: '''b'' in set elems "abc"'
		          specification: ''
		          states: Dictionary new
		          module: nil
		          diagrams: #( 'sequenceDiagram' ).
	self assert: (worker valueFromResult: result) equals: true viennaString.
	self assert: (worker prestatesFromResult: result) equals: Dictionary new.
	self assert: (worker poststatesFromResult: result) equals: Dictionary new.
	self assert: (worker messageFromResult: result) equals: nil.
	self
		assert: (worker
				 diagram: 'sequenceDiagram'
				 fromResult: result
				 ifPresent: [ true ]
				 ifAbsent: [ false ])
		equals: true
]

{ #category : 'tests' }
VDMPadWorkerPoolTest >> testNoSpecStateDiagram [

	| result |
	result := worker
		          evaluate: '''b'' in set elems "abc"'
		          specification: ''
		          states: Dictionary new
		          module: nil
		          diagrams: #( 'stateDiagram' ).
	self assert: (worker valueFromResult: result) equals: true viennaString.
	self assert: (worker prestatesFromResult: result) equals: Dictionary new.
	self assert: (worker poststatesFromResult: result) equals: Dictionary new.
	self assert: (worker messageFromResult: result) equals: nil.
	self
		assert: (worker
				 diagram: 'stateDiagram'
				 fromResult: result
				 ifPresent: [ true ]
				 ifAbsent: [ false ])
		equals: true
]

{ #category : 'tests' }
VDMPadWorkerPoolTest >> testSequenceDiagram [

	| result |
	result := worker
		          evaluate: '(Counter`click();Counter`show())'
		          specification: self modularCounterSpec
		          states: Dictionary new
		          module: nil
		          diagrams: #( 'sequenceDiagram' ).
	self assert: (worker valueFromResult: result) equals: '1'.
	self assert: (worker prestatesFromResult: result) equals: Dictionary new.
	self assert: (worker poststatesFromResult: result) equals: { ('Counter' -> { ('count' -> '1') } asDictionary) } asDictionary.
	self assert: (worker messageFromResult: result) equals: nil.
	self
		assert: (worker
				 diagram: 'sequenceDiagram'
				 fromResult: result
				 ifPresent: [ true ]
				 ifAbsent: [ false ])
		equals: true
]
