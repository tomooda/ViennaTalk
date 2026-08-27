"
I am a presenter that renders a markdown with ViennaDoc-like extension that let the user to evaluate VDM-SL expressions and statements.
"
Class {
	#name : 'ViennaMicrodownPresenter',
	#superclass : 'MicrodownPresenter',
	#instVars : [
		'#source => ObservableSlot',
		'#animation',
		'#highlighter'
	],
	#category : 'ViennaTalk-Microdown-Spec2',
	#package : 'ViennaTalk-Microdown',
	#tag : 'Spec2'
}

{ #category : 'specs' }
ViennaMicrodownPresenter class >> adapterName [

	^ #ViennaMorphicMicrodownAdapter
]

{ #category : 'examples' }
ViennaMicrodownPresenter class >> example [

	| spec presenter |
	spec := 'module Counter
exports all
definitions
state Counter of
    count : nat
init s == s = mk_Counter(0)
end
operations
click : () ==> ()
click() == count := count + 1;
show : () ==> nat
show() == return count;
end Counter'.
	presenter := self new
		             animation: (ViennaTranspiledAnimation new
				              specification: spec;
				              yourself);
		             documentFromString: '# Example evaluatable documentation

## abstract
This document explains a specification of a simple counter.
The counter is specified in VDM-SL and is animatable.
Click on any **run** button to understand what the counter does.
Enjoy!

## the Counter module
```vienna-source|module=Counter
```

### description
The **Counter** module specifies a counter. The module memorizes how many times the click operation has been called, and returns it via the show operation.
Easy!

### public operations

#### click
```vienna-source|module=Counter
click
```
```vienna-exec
Counter`click()
```

#### show
```vienna-source|module=Counter
show
```
```vienna-eval|module=Counter&state=no
show()
```

### internal state
```vienna-watch|module=Counter
count
```

Enjoy!
';
		             yourself.
	presenter open title: 'ViennaMicrodown'.
	^ presenter
]

{ #category : 'accessing' }
ViennaMicrodownPresenter >> animation [

	^ animation
]

{ #category : 'accessing' }
ViennaMicrodownPresenter >> animation: aViennaTranspiledAnimation [

	animation == aViennaTranspiledAnimation ifTrue: [ ^ self ].
	animation ifNotNil: [ animation announcer unsubscribe: self ].
	animation := aViennaTranspiledAnimation.
	animation announcer when: ViennaAnimationSpecificationChanged , ViennaAnimationEvaluated send: #recompose to: self
]

{ #category : 'defaults' }
ViennaMicrodownPresenter >> defaultTextStyler [

	^ ViennaMicTextStyler new
]

{ #category : 'initialization' }
ViennaMicrodownPresenter >> initialize [

	super initialize.
	self textStyler: self defaultTextStyler
]

{ #category : 'composing' }
ViennaMicrodownPresenter >> recompose [

	self withAdapterDo: [ :microdownAdapter | microdownAdapter recompose ]
]

{ #category : 'initialization' }
ViennaMicrodownPresenter >> setText: aText [

	self withAdapterDo: [ :a | a widgetDo: [ :w | w textArea privateReplaceFrom: 1 to: w text size with: aText ] ]
]

{ #category : 'api' }
ViennaMicrodownPresenter >> source [

	^ source
]

{ #category : 'api' }
ViennaMicrodownPresenter >> source: aString [

	source ~= aString ifTrue: [
			source := aString.
			self documentFromString: aString ]
]

{ #category : 'api - events' }
ViennaMicrodownPresenter >> whenSourceChangedDo: aBlock [

	self property: #source whenChangedDo: aBlock
]
