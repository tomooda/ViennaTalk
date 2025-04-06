Class {
	#name : 'ViennaProfiler',
	#superclass : 'Object',
	#instVars : [
		'actLink',
		'rdLink',
		'wrLink',
		'act',
		'rd',
		'wr'
	],
	#category : 'ViennaTalk-Profiler-Core',
	#package : 'ViennaTalk-Profiler-Core'
}

{ #category : 'examples' }
ViennaProfiler class >> example [

	| obj profiler |
	obj := ViennaProfilerTestTarget new.
	profiler := ViennaProfiler new.
	profiler
		act: { {
				obj.
				#op } }
		rd: { {
				obj.
				#x } }
		wr: { {
				obj.
				#y } }
		do: [
			obj op.
			profiler inspect ]
]

{ #category : 'private' }
ViennaProfiler >> act [

	^ act
]

{ #category : 'profiling' }
ViennaProfiler >> act: aCollectionOfModuleObjectAndSelector rd: aCollectionOfModuleObjectAndVariable wr: anotherCollectionOfModuleObjectAndVariable do: aBlock [

	[
	self
		installAct: aCollectionOfModuleObjectAndSelector
		rd: aCollectionOfModuleObjectAndVariable
		wr: anotherCollectionOfModuleObjectAndVariable.
	aBlock
		on: ViennaProfilingException
		do: [ :ex | ex resume: (ex value: self) ] ] ensure: [
		self uninstall ]
]

{ #category : 'private' }
ViennaProfiler >> countAct: context [

	act add: {
			context receiver class name.
			context selector }
]

{ #category : 'private' }
ViennaProfiler >> countRd: node [

	rd add: {
			node variable owningClass name.
			node name }
]

{ #category : 'private' }
ViennaProfiler >> countWr: node [

	wr add: {
			node variable owningClass name.
			node name }
]

{ #category : 'initialization' }
ViennaProfiler >> initialize [

	super initialize.
	actLink := MetaLink new
		           metaObject: self;
		           selector: #countAct:;
		           arguments: #( context );
		           control: #before;
		           yourself.
	rdLink := MetaLink new
		          metaObject: self;
		          selector: #countRd:;
		          arguments: #( node );
		          control: #after;
		          yourself.
	wrLink := MetaLink new
		          metaObject: self;
		          selector: #countWr:;
		          arguments: #( node );
		          control: #after;
		          yourself.
	act := Bag new.
	rd := Bag new.
	wr := Bag new
]

{ #category : 'reflectivity' }
ViennaProfiler >> installAct: aCollectionOfModuleObjectAndSelector rd: aCollectionOfModuleObjectAndVariable wr: anotherCollectionOfModuleObjectAndVariable [

	aCollectionOfModuleObjectAndSelector do: [ :pair |
		(pair first class lookupSelector: pair second) ifNotNil: [ :method |
			method ast link: actLink ] ].
	aCollectionOfModuleObjectAndVariable do: [ :pair |
		| class var |
		class := pair first class.
		var := pair second.
		class slotNamed: var ifFound: [ :slot |
			(class allMethodsReadingSlot: slot) do: [ :method |
				method instanceVariableReadNodes do: [ :node |
					node name = var ifTrue: [ node link: rdLink ] ] ] ] ].
	anotherCollectionOfModuleObjectAndVariable do: [ :pair |
		| class var |
		class := pair first class.
		var := pair second.
		class slotNamed: var ifFound: [ :slot |
			(class allMethodsWritingSlot: slot) do: [ :method |
				method instanceVariableWriteNodes do: [ :node |
					node name = var ifTrue: [ node link: wrLink ] ] ] ] ]
]

{ #category : 'accessing' }
ViennaProfiler >> numAct: opName module: moduleName [

	^ act occurrencesOf: {
			  moduleName.
			  opName }
]

{ #category : 'accessing' }
ViennaProfiler >> numRd: varName module: moduleName [

	^ rd occurrencesOf: {
			  moduleName.
			  varName }
]

{ #category : 'accessing' }
ViennaProfiler >> numWr: varName module: moduleName [

	^ wr occurrencesOf: {
			  moduleName.
			  varName }
]

{ #category : 'reflectivity' }
ViennaProfiler >> uninstall [

	actLink uninstall.
	rdLink uninstall.
	wrLink uninstall
]
