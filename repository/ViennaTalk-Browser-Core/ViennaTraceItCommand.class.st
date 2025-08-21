Class {
	#name : 'ViennaTraceItCommand',
	#superclass : 'CmCommand',
	#category : 'ViennaTalk-Browser-Core-Spec2',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'Spec2'
}

{ #category : 'defaults' }
ViennaTraceItCommand class >> defaultDescription [

	^ 'Record an execution trace of evaluating the selected expression'
]

{ #category : 'defaults' }
ViennaTraceItCommand class >> defaultIconName [

	^ #redCircle
]

{ #category : 'defaults' }
ViennaTraceItCommand class >> defaultName [

	^ 'Trace it'
]

{ #category : 'defaults' }
ViennaTraceItCommand class >> defaultShortcut [

	^ nil
]

{ #category : 'instance creation' }
ViennaTraceItCommand class >> forSpecContext: anObject [

	^ (super forSpecContext: anObject)
		  iconName: self defaultIconName;
		  shortcutKey: self defaultShortcut;
		  yourself
]

{ #category : 'executing' }
ViennaTraceItCommand >> execute [

	context ifNotNil: #doTraceIt
]
