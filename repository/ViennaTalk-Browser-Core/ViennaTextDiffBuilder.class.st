Class {
	#name : 'ViennaTextDiffBuilder',
	#superclass : 'TextDiffBuilder',
	#instVars : [
		'normalTextAttributes',
		'insertTextAttributes',
		'removeTextAttributes'
	],
	#category : 'ViennaTalk-Browser-Core-Diff',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'Diff'
}

{ #category : 'creating patches' }
ViennaTextDiffBuilder >> buildDisplayPatch [

	^Text streamContents: [ :stream |
		self
			patchSequenceDoIfMatch: [ :string |
				self print: string withAttributes: self normalTextAttributes on: stream ]
			ifInsert: [ :string |
				self print: string withAttributes: self insertTextAttributes on: stream ]
			ifRemove: [ :string |
				self print: string withAttributes: self removeTextAttributes on: stream ] ]
]

{ #category : 'initialization' }
ViennaTextDiffBuilder >> initialize [

	super initialize.
	normalTextAttributes := {  }.
	insertTextAttributes := { TextEmphasis underlined }.
	removeTextAttributes := { TextEmphasis struckOut }
]

{ #category : 'accessing' }
ViennaTextDiffBuilder >> insertTextAttributes [

	^ insertTextAttributes
]

{ #category : 'accessing' }
ViennaTextDiffBuilder >> insertTextAttributes: anArrayOfTextAttribute [

	insertTextAttributes := anArrayOfTextAttribute
]

{ #category : 'accessing' }
ViennaTextDiffBuilder >> normalTextAttributes [

	^ normalTextAttributes
]

{ #category : 'accessing' }
ViennaTextDiffBuilder >> normalTextAttributes: anArrayOfTextAttribute [

	normalTextAttributes := anArrayOfTextAttribute
]

{ #category : 'accessing' }
ViennaTextDiffBuilder >> removeTextAttributes [

	^ removeTextAttributes
]

{ #category : 'accessing' }
ViennaTextDiffBuilder >> removeTextAttributes: anArrayOfTextAttribute [

	removeTextAttributes := anArrayOfTextAttribute
]
