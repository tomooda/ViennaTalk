Class {
	#name : 'ViennaRecordStateNotification',
	#superclass : 'Notification',
	#instVars : [
		'transpiledObject'
	],
	#category : 'ViennaTalk-Transpiler-Core',
	#package : 'ViennaTalk-Transpiler-Core'
}

{ #category : 'signalling' }
ViennaRecordStateNotification class >> signalOn: aViennaTranspiledObject [

	^ self new
		  transpiledObject: aViennaTranspiledObject;
		  signal
]

{ #category : 'accessing' }
ViennaRecordStateNotification >> transpiledObject [

	^ transpiledObject
]

{ #category : 'accessing' }
ViennaRecordStateNotification >> transpiledObject: aViennaTranspiledObject [

	transpiledObject := aViennaTranspiledObject
]
