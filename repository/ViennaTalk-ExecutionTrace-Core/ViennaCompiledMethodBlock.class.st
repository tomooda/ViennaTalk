Class {
	#name : 'ViennaCompiledMethodBlock',
	#superclass : 'Object',
	#instVars : [
		'receiver',
		'compiledMethod'
	],
	#category : 'ViennaTalk-ExecutionTrace-Core-Utilities',
	#package : 'ViennaTalk-ExecutionTrace-Core',
	#tag : 'Utilities'
}

{ #category : 'instance creation' }
ViennaCompiledMethodBlock class >> receiver: anObject compiledMethod: aCompiledMethod [

	^ self new
		  receiver: anObject;
		  compiledMethod: aCompiledMethod;
		  yourself
]

{ #category : 'accessing' }
ViennaCompiledMethodBlock >> compiledMethod [

	^ compiledMethod
]

{ #category : 'accessing' }
ViennaCompiledMethodBlock >> compiledMethod: aCompiledMethod [

	compiledMethod := aCompiledMethod
]

{ #category : 'evaluating' }
ViennaCompiledMethodBlock >> cull: anObject [

	^ compiledMethod numArgs = 0
		  ifTrue: [ self value ]
		  ifFalse: [ self value: anObject ]
]

{ #category : 'evaluating' }
ViennaCompiledMethodBlock >> cull: anObject cull: anotherObject [

	^ compiledMethod numArgs < 2
		  ifTrue: [ self cull: anObject ]
		  ifFalse: [ self value: anObject value: anotherObject ]
]

{ #category : 'evaluating' }
ViennaCompiledMethodBlock >> cull: anObject cull: anotherObject cull: yetAnotherObject [

	^ compiledMethod numArgs < 3
		  ifTrue: [ self cull: anObject cull: anotherObject ]
		  ifFalse: [
		  self value: anObject value: anotherObject value: yetAnotherObject ]
]

{ #category : 'evaluating' }
ViennaCompiledMethodBlock >> cull: arg1 cull: arg2 cull: arg3 cull: arg4 [

	^ compiledMethod numArgs < 4
		  ifTrue: [ self cull: arg1 cull: arg2 cull: arg3 ]
		  ifFalse: [
				  self
					  value: arg1
					  value: arg2
					  value: arg3
					  value: arg4 ]
]

{ #category : 'accessing' }
ViennaCompiledMethodBlock >> numArgs [

	^ compiledMethod numArgs
]

{ #category : 'accessing' }
ViennaCompiledMethodBlock >> receiver [

	^ receiver
]

{ #category : 'accessing' }
ViennaCompiledMethodBlock >> receiver: anObject [

	receiver := anObject
]

{ #category : 'evaluating' }
ViennaCompiledMethodBlock >> value [

	^ receiver withArgs: #(  ) executeMethod: compiledMethod
]

{ #category : 'evaluating' }
ViennaCompiledMethodBlock >> value: anObject [

	^ receiver withArgs: { anObject } executeMethod: compiledMethod
]

{ #category : 'evaluating' }
ViennaCompiledMethodBlock >> value: anObject value: anotherObject [

	^ receiver
		  withArgs: {
				  anObject.
				  anotherObject }
		  executeMethod: compiledMethod
]

{ #category : 'evaluating' }
ViennaCompiledMethodBlock >> value: anObject value: anotherObject value: yetAnotherObject [

	^ receiver
		  withArgs: {
				  anObject.
				  anotherObject.
				  yetAnotherObject }
		  executeMethod: compiledMethod
]

{ #category : 'evaluating' }
ViennaCompiledMethodBlock >> value: arg1 value: arg2 value: arg3 value: arg4 [

	^ receiver
		  withArgs: {
				  arg1.
				  arg2.
				  arg3.
				  arg4 }
		  executeMethod: compiledMethod
]

{ #category : 'evaluating' }
ViennaCompiledMethodBlock >> valueWithArguments: anArray [

	^ receiver withArgs: anArray asArray executeMethod: compiledMethod
]

{ #category : 'evaluating' }
ViennaCompiledMethodBlock >> valueWithEnoughArguments: anArray [

	^ compiledMethod numArgs = anArray size
		  ifTrue: [ self valueWithArguments: anArray ]
		  ifFalse: [
				  self valueWithArguments:
					  (anArray
						   copyFrom: 1
						   to: (compiledMethod numArgs min: anArray size)) ]
]
