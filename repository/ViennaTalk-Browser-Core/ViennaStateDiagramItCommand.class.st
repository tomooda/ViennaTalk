Class {
	#name : 'ViennaStateDiagramItCommand',
	#superclass : 'CmCommand',
	#category : 'ViennaTalk-Browser-Core-Spec2',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'Spec2'
}

{ #category : 'defaults' }
ViennaStateDiagramItCommand class >> defaultDescription [

	^ 'Evaluate the selected expression and open an abstract state diagram from it'
]

{ #category : 'defaults' }
ViennaStateDiagramItCommand class >> defaultIconName [

	^ #inspect
]

{ #category : 'defaults' }
ViennaStateDiagramItCommand class >> defaultName [

	^ 'State it'
]

{ #category : 'defaults' }
ViennaStateDiagramItCommand class >> defaultShortcut [

	^ nil
]

{ #category : 'instance creation' }
ViennaStateDiagramItCommand class >> forSpecContext: anObject [

	^ (super forSpecContext: anObject)
		  iconName: self defaultIconName;
		  shortcutKey: self defaultShortcut;
		  yourself
]

{ #category : 'executing' }
ViennaStateDiagramItCommand >> execute [

	context ifNotNil: #doStateDiagramIt
]
