Class {
	#name : 'ViennaMicTopLevelReference',
	#superclass : 'ViennaMicReference',
	#instVars : [
		'moduleName',
		'identifier'
	],
	#category : 'ViennaTalk-Microdown-Microdown',
	#package : 'ViennaTalk-Microdown',
	#tag : 'Microdown'
}

{ #category : 'instance creation' }
ViennaMicTopLevelReference class >> moduleName: aString identifier: anotherString [

	^ self new
		  moduleName: aString;
		  identifier: anotherString;
		  yourself
]

{ #category : 'accessing' }
ViennaMicTopLevelReference >> identifier [

	^ identifier
]

{ #category : 'accessing' }
ViennaMicTopLevelReference >> identifier: aString [

	identifier := aString
]

{ #category : 'accessing' }
ViennaMicTopLevelReference >> moduleName [

	^ moduleName
]

{ #category : 'accessing' }
ViennaMicTopLevelReference >> moduleName: aString [

	moduleName := aString
]
