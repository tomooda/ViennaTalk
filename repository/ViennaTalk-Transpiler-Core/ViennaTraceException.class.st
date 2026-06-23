Class {
	#name : 'ViennaTraceException',
	#superclass : 'Exception',
	#instVars : [
		'exception',
		'env'
	],
	#category : 'ViennaTalk-Transpiler-Core',
	#package : 'ViennaTalk-Transpiler-Core'
}

{ #category : 'instance creation' }
ViennaTraceException class >> on: anException env: aDictionary [

	^ self new
		  exception: anException;
		  env: aDictionary;
		  yourself
]

{ #category : 'accessing' }
ViennaTraceException >> env [

	^ env
]

{ #category : 'accessing' }
ViennaTraceException >> env: aDictionary [

	env := aDictionary
]

{ #category : 'accessing' }
ViennaTraceException >> exception [

	^ exception
]

{ #category : 'accessing' }
ViennaTraceException >> exception: anException [

	exception := anException freeze
]
