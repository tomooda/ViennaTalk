Class {
	#name : #ViennaVDMTaggedElementDecoderTest,
	#superclass : #TestCase,
	#instVars : [
		'decoder'
	],
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #running }
ViennaVDMTaggedElementDecoderTest >> setUp [
	decoder := ViennaVDMTaggedElementDecoder new
]

{ #category : #tests }
ViennaVDMTaggedElementDecoderTest >> testParseSimple [
	self
		assert: (decoder parse: 'mk_TaggedElement("svg", {|->}, {|->}, [], {}, 0)')
		equals:
			(ViennaTaggedElement
				name: 'svg'
				attributes: {} asDictionary
				eventHandlers: {} asDictionary
				contents: #()
				tokens: {} asSet
				identifier: 0)
]

{ #category : #tests }
ViennaVDMTaggedElementDecoderTest >> testParseWithAttributes [
	self
		assert:
			(decoder
				parse:
					'mk_TaggedElement("svg", { "x" |-> "0", "y" |-> "0", "width" |-> "800", "height" |-> "600"}, {|->}, [], {}, 0)')
		equals:
			(ViennaTaggedElement
				name: 'svg'
				attributes:
					{('x' -> '0').
					('y' -> '0').
					('width' -> '800').
					('height' -> '600')} asDictionary
				eventHandlers: {} asDictionary
				contents: #()
				tokens: {} asSet
				identifier: 0)
]

{ #category : #tests }
ViennaVDMTaggedElementDecoderTest >> testParseWithEventHandlers [
	self
		assert:
			(decoder
				parse:
					'mk_TaggedElement("svg", {|->}, {<click> |-> mk_Handler("Foo", "bar")}, [], {}, 0)')
		equals:
			(ViennaTaggedElement
				name: 'svg'
				attributes: {} asDictionary
				eventHandlers: {(#click -> #('Foo' 'bar'))} asDictionary
				contents: #()
				tokens: {} asSet
				identifier: 0)
]

{ #category : #tests }
ViennaVDMTaggedElementDecoderTest >> testParseWithStringContent [
	self
		assert:
			(decoder
				parse: 'mk_TaggedElement("svg", {|->}, {|->}, ["Foo"], {}, 0)')
		equals:
			(ViennaTaggedElement
				name: 'svg'
				attributes: {} asDictionary
				eventHandlers: {} asDictionary
				contents: #('Foo')
				tokens: {} asSet
				identifier: 0)
]

{ #category : #tests }
ViennaVDMTaggedElementDecoderTest >> testParseWithTaggedContent [
	self
		assert:
			(decoder
				parse:
					'mk_TaggedElement("svg", {|->}, {|->}, [mk_TaggedElement("text", {|->}, {|->}, [], {}, 1)], {}, 0)')
		equals:
			(ViennaTaggedElement
				name: 'svg'
				attributes: {} asDictionary
				eventHandlers: {} asDictionary
				contents:
					{(ViennaTaggedElement
						name: 'text'
						attributes: {} asDictionary
						eventHandlers: {} asDictionary
						contents: {}
						tokens: {} asSet
						identifier: 1)}
				tokens: {} asSet
				identifier: 0)
]

{ #category : #tests }
ViennaVDMTaggedElementDecoderTest >> testParseWithTokens [
	self
		assert:
			(decoder
				parse:
					'mk_TaggedElement("svg", {|->}, {|->}, [], {mk_token(<foo>), mk_token(<bar>)}, 0)')
		equals:
			(ViennaTaggedElement
				name: 'svg'
				attributes: {} asDictionary
				eventHandlers: {} asDictionary
				contents: {}
				tokens:
					{(ViennaType token value: #foo).
					(ViennaType token value: #bar)} asSet
				identifier: 0)
]
