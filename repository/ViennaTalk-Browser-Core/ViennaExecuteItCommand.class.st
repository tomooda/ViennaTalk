Class {
	#name : 'ViennaExecuteItCommand',
	#superclass : 'CmCommand',
	#category : 'ViennaTalk-Browser-Core-Spec2',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'Spec2'
}

{ #category : 'defaults' }
ViennaExecuteItCommand class >> defaultDescription [

	^ 'Execute the selected statement and print it'
]

{ #category : 'defaults' }
ViennaExecuteItCommand class >> defaultIconName [

	^ #smallDoIt
]

{ #category : 'defaults' }
ViennaExecuteItCommand class >> defaultName [

	^ 'Execute it'
]

{ #category : 'defaults' }
ViennaExecuteItCommand class >> defaultShortcut [

	^ OSPlatform current defaultModifier + $d
]

{ #category : 'instance creation' }
ViennaExecuteItCommand class >> forSpecContext: anObject [

	^ (super forSpecContext: anObject)
		  iconName: self defaultIconName;
		  shortcutKey: self defaultShortcut;
		  yourself
]

{ #category : 'executing' }
ViennaExecuteItCommand >> execute [

	context ifNotNil: #doExecuteIt
]
