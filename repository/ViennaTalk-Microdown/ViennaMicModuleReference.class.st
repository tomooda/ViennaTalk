Class {
	#name : 'ViennaMicModuleReference',
	#superclass : 'ViennaMicReference',
	#instVars : [
		'moduleName'
	],
	#category : 'ViennaTalk-Microdown-Microdown',
	#package : 'ViennaTalk-Microdown',
	#tag : 'Microdown'
}

{ #category : 'instance creation' }
ViennaMicModuleReference class >> moduleName: aString [

	^ self new
		  moduleName: aString;
		  yourself
]

{ #category : 'accessing' }
ViennaMicModuleReference >> moduleName [

	^ moduleName
]

{ #category : 'accessing' }
ViennaMicModuleReference >> moduleName: aString [

	moduleName := aString
]
