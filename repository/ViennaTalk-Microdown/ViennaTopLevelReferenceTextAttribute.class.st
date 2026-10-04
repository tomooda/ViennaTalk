Class {
	#name : 'ViennaTopLevelReferenceTextAttribute',
	#superclass : 'ViennaTextAttribute',
	#instVars : [
		'moduleName',
		'identifier'
	],
	#category : 'ViennaTalk-Microdown-Microdown',
	#package : 'ViennaTalk-Microdown',
	#tag : 'Microdown'
}

{ #category : 'instance creation' }
ViennaTopLevelReferenceTextAttribute class >> moduleName: aString identifier: anotherString [

	^ self new
		  moduleName: aString;
		  identifier: anotherString;
		  yourself
]

{ #category : 'accessing' }
ViennaTopLevelReferenceTextAttribute >> identifier [

	^ identifier
]

{ #category : 'accessing' }
ViennaTopLevelReferenceTextAttribute >> identifier: aString [

	identifier := aString
]

{ #category : 'accessing' }
ViennaTopLevelReferenceTextAttribute >> moduleName [

	^ moduleName
]

{ #category : 'accessing' }
ViennaTopLevelReferenceTextAttribute >> moduleName: aString [

	moduleName := aString
]
