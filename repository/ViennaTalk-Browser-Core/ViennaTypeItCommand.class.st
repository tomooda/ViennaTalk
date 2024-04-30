Class {
	#name : 'ViennaTypeItCommand',
	#superclass : 'CmCommand',
	#category : 'ViennaTalk-Browser-Core-Spec2',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'Spec2'
}

{ #category : 'defaults' }
ViennaTypeItCommand class >> defaultDescription [

	^ 'Typecheck the selected expression and print it'
]

{ #category : 'defaults' }
ViennaTypeItCommand class >> defaultIconName [

	^ #smallPrintIt
]

{ #category : 'defaults' }
ViennaTypeItCommand class >> defaultName [

	^ 'Type it'
]

{ #category : 'defaults' }
ViennaTypeItCommand class >> defaultShortcut [

	^ $t command
]

{ #category : 'instance creation' }
ViennaTypeItCommand class >> forSpecContext: anObject [

	^ (super forSpecContext: anObject)
		  iconName: self defaultIconName;
		  shortcutKey: self defaultShortcut;
		  yourself
]

{ #category : 'executing' }
ViennaTypeItCommand >> execute [

	context ifNotNil: #doTypeIt
]
