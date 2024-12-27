Class {
	#name : 'ViennaSemanticHiDeMatcher',
	#superclass : 'ViennaDiffSetHiDeMatcher',
	#category : 'ViennaTalk-Browser-Core-HiDeHo',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'HiDeHo'
}

{ #category : 'accessing' }
ViennaSemanticHiDeMatcher >> impactOf: aViennaEpiLog [

	| agenda transitiveClosure |
	agenda := Set withAll:
		          (self diffSet: aViennaEpiLog) changedGlobalNames.
	transitiveClosure := Set new: agenda size * 4.
	[ agenda notEmpty ] whileTrue: [
		| globalName |
		globalName := agenda anyOne.
		agenda remove: globalName.
		(transitiveClosure includes: globalName) ifFalse: [
			transitiveClosure add: globalName.
			self referersTo: globalName in: aViennaEpiLog do: [ :referer |
				(transitiveClosure includes: referer) ifFalse: [
					agenda add: referer ] ] ] ].
	^ transitiveClosure
]

{ #category : 'enumerfating' }
ViennaSemanticHiDeMatcher >> referersTo: aViennaGlobalName in: aViennaEpiLog do: aBlock [

	self
		referersTo: aViennaGlobalName
		inDocument: aViennaEpiLog specification
		do: aBlock;
		referersTo: aViennaGlobalName
		inDocument: (self prevFrom: aViennaEpiLog) specification
		do: aBlock
]

{ #category : 'enumerfating' }
ViennaSemanticHiDeMatcher >> referersTo: aViennaGlobalName inDocument: aViennaDocumentNode do: aBlock [

	aViennaDocumentNode ifNotNil: [
		(aViennaGlobalName resolveIn: aViennaDocumentNode) ifNotNil: [
			:referee |
			aViennaDocumentNode
				allDescendantsSuchThat: [ :node |
				node ~~ referee and: [ node resolve == referee ] ]
				do: [ :node |
					node topLevelDefinition globalNamesDo: [ :name |
						aBlock value: name ] ] ] ]
]
