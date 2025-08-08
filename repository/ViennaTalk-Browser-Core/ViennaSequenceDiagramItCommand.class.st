Class {
	#name : 'ViennaSequenceDiagramItCommand',
	#superclass : 'CmCommand',
	#category : 'ViennaTalk-Browser-Core-Spec2',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'Spec2'
}

{ #category : 'defaults' }
ViennaSequenceDiagramItCommand class >> defaultDescription [

	^ 'Evaluate the selected expression and open a sequence diagram from it'
]

{ #category : 'defaults' }
ViennaSequenceDiagramItCommand class >> defaultIconName [

	^ #inspect
]

{ #category : 'defaults' }
ViennaSequenceDiagramItCommand class >> defaultName [

	^ 'Sequence it'
]

{ #category : 'defaults' }
ViennaSequenceDiagramItCommand class >> defaultShortcut [

	^ nil
]

{ #category : 'instance creation' }
ViennaSequenceDiagramItCommand class >> forSpecContext: anObject [

	^ (super forSpecContext: anObject)
		  iconName: self defaultIconName;
		  shortcutKey: self defaultShortcut;
		  yourself
]

{ #category : 'executing' }
ViennaSequenceDiagramItCommand >> execute [

	context ifNotNil: #doSequenceDiagramIt
]
