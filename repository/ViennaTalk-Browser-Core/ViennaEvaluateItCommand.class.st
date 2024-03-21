Class {
	#name : #ViennaEvaluateItCommand,
	#superclass : #CmCommand,
	#category : #'ViennaTalk-Browser-Core-Spec2'
}

{ #category : #defaults }
ViennaEvaluateItCommand class >> defaultDescription [

	^ 'Evaluate the selected expression and print it'
]

{ #category : #defaults }
ViennaEvaluateItCommand class >> defaultIconName [

	^ #smallPrintIt
]

{ #category : #defaults }
ViennaEvaluateItCommand class >> defaultName [

	^ 'Evaluate it'
]

{ #category : #defaults }
ViennaEvaluateItCommand class >> defaultShortcut [

	^ $p command
]

{ #category : #'instance creation' }
ViennaEvaluateItCommand class >> forSpecContext: anObject [

	^ (super forSpecContext: anObject)
		  iconName: self defaultIconName;
		  shortcutKey: self defaultShortcut;
		  yourself
]

{ #category : #executing }
ViennaEvaluateItCommand >> execute [

	context ifNotNil: #doEvaluateIt
]
