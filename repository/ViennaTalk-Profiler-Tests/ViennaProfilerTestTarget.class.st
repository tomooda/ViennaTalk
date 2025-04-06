Class {
	#name : 'ViennaProfilerTestTarget',
	#superclass : 'Object',
	#instVars : [
		'x',
		'y'
	],
	#category : 'ViennaTalk-Profiler-Tests',
	#package : 'ViennaTalk-Profiler-Tests'
}

{ #category : 'initialization' }
ViennaProfilerTestTarget >> initialize [

	super initialize.
	x := 1.
	y := 2
]

{ #category : 'operations' }
ViennaProfilerTestTarget >> op [

	y := x + x.
	self yourself.
	^ self
]
