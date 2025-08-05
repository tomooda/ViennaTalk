Class {
	#name : 'ViennaSequenceItCommand',
	#superclass : 'CmCommand',
	#category : 'ViennaTalk-Browser-Core-Spec2',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'Spec2'
}

{ #category : 'defaults' }
ViennaSequenceItCommand class >> defaultDescription [

	^ 'Evaluate the selected expression and open a sequence diagram from it'
]

{ #category : 'defaults' }
ViennaSequenceItCommand class >> defaultIconName [

	^ #inspect
]

{ #category : 'defaults' }
ViennaSequenceItCommand class >> defaultName [

	^ 'Sequence it'
]

{ #category : 'defaults' }
ViennaSequenceItCommand class >> defaultShortcut [

	^ nil
]

{ #category : 'instance creation' }
ViennaSequenceItCommand class >> forSpecContext: anObject [

	^ (super forSpecContext: anObject)
		  iconName: self defaultIconName;
		  shortcutKey: self defaultShortcut;
		  yourself
]

{ #category : 'executing' }
ViennaSequenceItCommand >> execute [

	context ifNotNil: #doSequenceIt
]
