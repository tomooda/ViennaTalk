Class {
	#name : 'ViennaEngine',
	#superclass : 'ViennaAbstractEngine',
	#traits : 'TViennaEngine',
	#classTraits : 'TViennaEngine classTrait',
	#category : 'ViennaTalk-Engine-Core',
	#package : 'ViennaTalk-Engine-Core'
}

{ #category : 'defaults' }
ViennaEngine class >> default [

	^ self new
]

{ #category : 'accessing' }
ViennaEngine class >> engineType [

	^ #Transpiler
]

{ #category : 'accessing' }
ViennaEngine class >> priority [

	^ 10
]

{ #category : 'accessing' }
ViennaEngine >> close [

	
]

{ #category : 'class access' }
ViennaEngine >> transpilerClass [

	^ ViennaTranspilerForExecutionTracing
]
