Class {
	#name : 'ViennaRecordItCommand',
	#superclass : 'CmCommand',
	#category : 'ViennaTalk-Browser-Core-Spec2',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'Spec2'
}

{ #category : 'defaults' }
ViennaRecordItCommand class >> defaultDescription [

	^ 'Record an execution trace of evaluating the selected expression'
]

{ #category : 'defaults' }
ViennaRecordItCommand class >> defaultIconName [

	^ #redCircle
]

{ #category : 'defaults' }
ViennaRecordItCommand class >> defaultName [

	^ 'Record it'
]

{ #category : 'defaults' }
ViennaRecordItCommand class >> defaultShortcut [

	^ nil
]

{ #category : 'instance creation' }
ViennaRecordItCommand class >> forSpecContext: anObject [

	^ (super forSpecContext: anObject)
		  iconName: self defaultIconName;
		  shortcutKey: self defaultShortcut;
		  yourself
]

{ #category : 'executing' }
ViennaRecordItCommand >> execute [

	context ifNotNil: #doRecordIt
]
