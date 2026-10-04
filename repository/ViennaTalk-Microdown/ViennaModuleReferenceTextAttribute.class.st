Class {
	#name : 'ViennaModuleReferenceTextAttribute',
	#superclass : 'ViennaTextAttribute',
	#instVars : [
		'moduleName'
	],
	#category : 'ViennaTalk-Microdown-Microdown',
	#package : 'ViennaTalk-Microdown',
	#tag : 'Microdown'
}

{ #category : 'instance creation' }
ViennaModuleReferenceTextAttribute class >> moduleName: aString [

	^ self new
		  moduleName: aString;
		  yourself
]

{ #category : 'accessing' }
ViennaModuleReferenceTextAttribute >> moduleName [

	^ moduleName
]

{ #category : 'accessing' }
ViennaModuleReferenceTextAttribute >> moduleName: aString [

	moduleName := aString
]
