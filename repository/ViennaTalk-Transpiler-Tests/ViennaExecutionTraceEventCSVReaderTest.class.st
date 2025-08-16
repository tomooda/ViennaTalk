Class {
	#name : 'ViennaExecutionTraceEventCSVReaderTest',
	#superclass : 'TestCase',
	#instVars : [
		'reader'
	],
	#category : 'ViennaTalk-Transpiler-Tests',
	#package : 'ViennaTalk-Transpiler-Tests'
}

{ #category : 'running' }
ViennaExecutionTraceEventCSVReaderTest >> setUp [

	reader := ViennaExecutionTraceEventCSVReader new
]

{ #category : 'tests' }
ViennaExecutionTraceEventCSVReaderTest >> testReadAssignmentEvent [

	| event |
	event := reader readAssignmentEvent:
		         { 'A'. 'foo:=1'. 'bar:=2'. 'baz:=3'. 'quuux:=<quuux>' }.
	self assert: event class identicalTo: reader assignmentEventClass.
	self assert: event module equals: 'A'.
	self assert: event assignments equals: {
			('foo' -> 1).
			('bar' -> 2).
			('baz' -> 3).
			('quuux' -> #quuux) }
]

{ #category : 'tests' }
ViennaExecutionTraceEventCSVReaderTest >> testReadOperationCallEvent [

	| event assign ret |
	reader inputStream:
		('a,B,quuux:=nil' , String cr , 'r,B,foo,()' , String cr
		 , 'a,A,bar:="baz"') readStream.
	event := reader readOperationCallEvent:
		         { 'B'. 'foo'. '1'. '<quuux>' }.
	self assert: event class identicalTo: reader operationCallEventClass.
	self assert: event module equals: 'B'.
	self assert: event operation equals: 'foo'.
	self assert: event arguments equals: { 1. #quuux }.
	self assert: event events size equals: 2.
	assign := event events first.
	ret := event events second.
	self assert: assign class identicalTo: reader assignmentEventClass.
	self assert: ret class identicalTo: reader returnEventClass
]

{ #category : 'tests' }
ViennaExecutionTraceEventCSVReaderTest >> testReadReturnEvent [

	| event |
	event := reader readReturnEvent: { 'A'. 'quuux'. '<quuux>' }.
	self assert: event class identicalTo: reader returnEventClass.
	self assert: event module equals: 'A'.
	self assert: event operation equals: 'quuux'.
	self assert: event returnValue equals: #quuux
]

{ #category : 'tests' }
ViennaExecutionTraceEventCSVReaderTest >> testReadRootEvent [

	| event assign1 assign2 |
	reader inputStream: 'a,B,quuux:=nil' readStream.
	event := reader readRootEvent:
		         { 'A'. 'foo:=1'. 'bar:=2'. 'B'. 'baz:=3'. 'quuux:=<quuux>' }.
	self assert: event class identicalTo: reader rootEventClass.
	self assert: event initial size equals: 2.
	assign1 := event initial first.
	assign2 := event initial second.
	self assert: assign1 module equals: 'A'.
	self assert: assign1 assignments equals: {
			('foo' -> 1).
			('bar' -> 2) }.
	self assert: assign2 module equals: 'B'.
	self assert: assign2 assignments equals: {
			('baz' -> 3).
			('quuux' -> #quuux) }.
	self assert: event events size equals: 1.
	self
		assert: event events first class
		equals: reader assignmentEventClass
]

{ #category : 'tests' }
ViennaExecutionTraceEventCSVReaderTest >> testUnescape [

	self
		assert:
		(reader unescape: 'foo\,bar\\baz \quuux\ ')
		equals: 'foo,bar\baz quuux '
]

{ #category : 'tests' }
ViennaExecutionTraceEventCSVReaderTest >> testValuesFromLine [

	self
		assert:
		(reader valuesFromLine: 'abc\,def, foo bar baz \quuux, xyz\')
		equals: { 'abc,def'. 'foo bar baz quuux'. 'xyz\' }
]
