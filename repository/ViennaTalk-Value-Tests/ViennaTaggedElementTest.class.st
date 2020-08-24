Class {
	#name : #ViennaTaggedElementTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Value-Tests'
}

{ #category : #tests }
ViennaTaggedElementTest >> testNeoJsonOn [
	| stream writer element json svg |
	stream := String new writeStream.
	writer := NeoJSONWriter on: stream.
	element := ViennaTaggedElement
		name: 'svg'
		attributes:
			{('x' -> '0').
			('y' -> '0').
			('width' -> '800').
			('height' -> '600')} asDictionary
		eventHandlers: {(#click -> #('Foo' 'bar'))} asDictionary
		contents:
			{(ViennaTaggedElement
				name: 'text'
				attributes: {} asDictionary
				eventHandlers: {} asDictionary
				contents: {}
				tokens: {} asSet
				identifier: 1).
			'Text'}
		tokens:
			{(ViennaType token value: #foo).
			(ViennaType token value: #bar)} asSet
		identifier: 0.
	element neoJsonOn: writer.
	json := NeoJSONReader fromString: stream contents.
	self assert: json isDictionary.
	self assert: json size equals: 1.
	svg := json at: 'TaggedElement'.
	self assert: svg isArray.
	self assert: svg first equals: 'svg'.
	self
		assert: svg second
		equals:
			{('x' -> '0').
			('y' -> '0').
			('width' -> '800').
			('height' -> '600')} asDictionary.
	self
		assert: svg third
		equals:
			{('click' -> {('Handler' -> {'Foo' . 'bar'})} asDictionary)}
				asDictionary.
	self assert: svg fourth isArray.
	self assert: svg fourth size equals: 2.
	self assert: (svg fourth first includesKey: 'TaggedElement').
	self assert: svg fourth second equals: 'Text'.
	self
		assert: svg fifth asSet
		equals:
			{{('token' -> 'foo')} asDictionary.
			{('token' -> 'bar')} asDictionary} asSet.
	self assert: svg sixth equals: 0
]

{ #category : #tests }
ViennaTaggedElementTest >> testPrintXmlOn [
	| stream element xml |
	stream := String new writeStream.
	element := ViennaTaggedElement
		name: 'svg'
		attributes:
			{('x' -> '0').
			('y' -> '0').
			('width' -> '800').
			('height' -> '600').
			('viewBox' -> '0 0 800 600')} asDictionary
		eventHandlers: {(#click -> #('Foo' 'bar'))} asDictionary
		contents:
			{(ViennaTaggedElement
				name: 'text'
				attributes:
					{('x' -> '0').
					('y' -> '100').
					('font-family' -> 'Helvetica').
					('font-size' -> '36')} asDictionary
				eventHandlers: {} asDictionary
				contents: {'Howdy'}
				tokens: {} asSet
				identifier: 1)}
		tokens:
			{(ViennaType token value: #foo).
			(ViennaType token value: #bar)} asSet
		identifier: 0.
	element printXmlOn: stream.
	xml := stream contents.
	self assert: ('<svg *' match: xml).
	self assert: ('*width="800"*' match: xml).
	self assert: ('*onclick="*' match: xml)
]
