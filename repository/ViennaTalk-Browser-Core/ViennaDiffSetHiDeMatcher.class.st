Class {
	#name : 'ViennaDiffSetHiDeMatcher',
	#superclass : 'ViennaHiDeMatcher',
	#instVars : [
		'epiLogEnumerator'
	],
	#category : 'ViennaTalk-Browser-Core-HiDeHo',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'HiDeHo'
}

{ #category : 'accessing' }
ViennaDiffSetHiDeMatcher >> diffSet: aViennaEpiLog [

	^ epiLogEnumerator diffSet: aViennaEpiLog
]

{ #category : 'accessing' }
ViennaDiffSetHiDeMatcher >> epiLogEnumerator [

	^ epiLogEnumerator
]

{ #category : 'accessing' }
ViennaDiffSetHiDeMatcher >> epiLogEnumerator: aViennaEpiLogEnumerator [

	epiLogEnumerator := aViennaEpiLogEnumerator
]

{ #category : 'accessing' }
ViennaDiffSetHiDeMatcher >> impactOf: aViennaEpiLog [

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
			self
				transitionsFrom: globalName
				in: aViennaEpiLog
				do: [ :referer |
					(transitiveClosure includes: referer) ifFalse: [
						agenda add: referer ] ] ] ].
	^ transitiveClosure
]

{ #category : 'accessing' }
ViennaDiffSetHiDeMatcher >> prevFrom: aViennaEpiLog [

	^ epiLogEnumerator prevFrom: aViennaEpiLog
]

{ #category : 'enumerfating' }
ViennaDiffSetHiDeMatcher >> refereesFrom: aViennaGlobalName in: aViennaEpiLog do: aBlock [

	self
		refereesFrom: aViennaGlobalName
		inDocument: aViennaEpiLog specification
		do: aBlock;
		refereesFrom: aViennaGlobalName
		inDocument: (self prevFrom: aViennaEpiLog) specification
		do: aBlock
]

{ #category : 'enumerfating' }
ViennaDiffSetHiDeMatcher >> refereesFrom: aViennaGlobalName inDocument: aViennaDocumentNode do: aBlock [

	aViennaDocumentNode ifNotNil: [
		(aViennaGlobalName resolveIn: aViennaDocumentNode) ifNotNil: [
			:referer |
			referer
				allDescendantsSuchThat: [ :node | node isViennaNameNode ]
				do: [ :nameNode |
					nameNode resolve ifNotNil: [ :refree |
						refree topLevelDefinition ifNotNil: [ :toplevel |
							toplevel globalNamesDo: [ :refreeGlobalName |
								aBlock value: refreeGlobalName ] ] ] ] ] ]
]

{ #category : 'enumerfating' }
ViennaDiffSetHiDeMatcher >> referersTo: aViennaGlobalName in: aViennaEpiLog do: aBlock [

	self
		referersTo: aViennaGlobalName
		inDocument: aViennaEpiLog specification
		do: aBlock;
		referersTo: aViennaGlobalName
		inDocument: (self prevFrom: aViennaEpiLog) specification
		do: aBlock
]

{ #category : 'enumerfating' }
ViennaDiffSetHiDeMatcher >> referersTo: aViennaGlobalName inDocument: aViennaDocumentNode do: aBlock [

	aViennaDocumentNode ifNotNil: [
		(aViennaGlobalName resolveIn: aViennaDocumentNode) ifNotNil: [
			:referee |
			aViennaDocumentNode
				allDescendantsSuchThat: [ :node |
				node ~~ referee and: [ node resolve == referee ] ]
				do: [ :node |
					node topLevelDefinition ifNotNil: [ :toplevel |
						toplevel globalNamesDo: [ :name | aBlock value: name ] ] ] ] ]
]

{ #category : 'enumerfating' }
ViennaDiffSetHiDeMatcher >> transitionsFrom: aViennaGlobalName in: aViennaEpiLog do: aBlock [

	^ self subclassResponsibility
]

{ #category : 'evaluating' }
ViennaDiffSetHiDeMatcher >> value: aViennaEpiLog value: anotherViennaEpiLog [

	^ (self impactOf: aViennaEpiLog) includesAny:
		  (self impactOf: anotherViennaEpiLog)
]
