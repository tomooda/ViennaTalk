Class {
	#name : #ViennaFRAMAnnotationParserTest,
	#superclass : #TestCase,
	#instVars : [
		'parser'
	],
	#category : #'ViennaTalk-FRAM-Tests'
}

{ #category : #running }
ViennaFRAMAnnotationParserTest >> setUp [

	parser := ViennaFRAMAnnotationParser new
]

{ #category : #tests }
ViennaFRAMAnnotationParserTest >> testFramAnnotation [

	self
		assert: (parser parse: 'FRAM control name')
		equals: { $c. 'name' }.
	self
		assert: (parser parse: 'FRAM Input name can be long')
		equals: { $i. 'name can be long' }.
	self
		assert: (parser parse: 'FRAM o name will be trimmed.    ')
		equals: { $o. 'name will be trimmed.' }.
	self assert: (parser parse: 'FRAM P') equals: { $p. '' }.
	self
		assert: (parser parse: 'FRAM resource ｎａｍｅ')
		equals: { $r. 'ｎａｍｅ' }.
	self assert: (parser parse: 'FRAM tcanleadanysuffix   ') equals: { $t. '' }.
	self
		assert: (parser parse: 'FRAM function name')
		equals: { $f. 'name' }
]
