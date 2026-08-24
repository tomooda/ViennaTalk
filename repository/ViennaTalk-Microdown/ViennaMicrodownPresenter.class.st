"
I am a presenter that renders a markdown with ViennaDoc-like extension that let the user to evaluate VDM-SL expressions and statements.
"
Class {
	#name : 'ViennaMicrodownPresenter',
	#superclass : 'MicrodownPresenter',
	#instVars : [
		'animation',
		'highlighter'
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

	animation := aViennaTranspiledAnimation
]

{ #category : 'accessing' }
ViennaMicrodownPresenter >> highlight: aString [

	^ (highlighter ifNil: [ highlighter := ViennaVDMHighlighter new ])
		  text: aString asText;
		  parse: aString asString;
		  text
]

{ #category : 'error messaging' }
ViennaMicrodownPresenter >> noDefinitionError: aString [

	^ 'No definition of ' , aString
]

{ #category : 'error messaging' }
ViennaMicrodownPresenter >> noModuleError: aString [

	^ 'No module named ' , aString
]

{ #category : 'error messaging' }
ViennaMicrodownPresenter >> noSpecificationError [

	^ 'Specification is not available'
]

{ #category : 'composing' }
ViennaMicrodownPresenter >> recompose [

	self withAdapterDo: [ :microdownAdapter | microdownAdapter recompose ]
]

{ #category : 'initialization' }
ViennaMicrodownPresenter >> setText: aText [

	self withAdapterDo: [ :a | a widgetDo: [ :w | w textArea privateReplaceFrom: 1 to: w text size with: aText ] ]
]

{ #category : 'accessing' }
ViennaMicrodownPresenter >> sourceAt: aViennaNameNode in: anotherString ifError: errorBlock [

	^ (animation ifNotNil: #specificationNode)
		  ifNotNil: [ :specificationNode |
				  (anotherString isNil or: [ anotherString = animation defaultModule ])
					  ifTrue: [
							  aViennaNameNode
								  ifNotNil: [
										  aViennaNameNode parent: specificationNode.
										  aViennaNameNode resolve
											  ifNotNil: [ :node | self highlight: node source ]
											  ifNil: [ errorBlock value: (self noDefinitionError: aViennaNameNode source) ] ]
								  ifNil: [ self highlight: specificationNode source ] ]
					  ifFalse: [
							  (specificationNode moduleNamed: anotherString)
								  ifNotNil: [ :moduleNode |
										  aViennaNameNode
											  ifNotNil: [
													  aViennaNameNode parent: moduleNode.
													  aViennaNameNode resolve
														  ifNotNil: [ :node | self highlight: node source ]
														  ifNil: [ errorBlock value: (self noDefinitionError: aViennaNameNode source) ] ]
											  ifNil: [ self highlight: moduleNode source ] ]
								  ifNil: [ errorBlock value: (self noModuleError: anotherString) ] ] ]
		  ifNil: [ self noSpecificationError ]
]

{ #category : 'error messaging' }
ViennaMicrodownPresenter >> syntaxError [

	^ 'Syntax error in the body'
]

{ #category : 'accessing' }
ViennaMicrodownPresenter >> transpiledSpecification [

	^ animation ifNotNil: #transpiledSpecification
]
