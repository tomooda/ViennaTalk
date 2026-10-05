Class {
	#name : 'ViennaStateVariableReferenceListPresenter',
	#superclass : 'ViennaReferenceListPresenter',
	#category : 'ViennaTalk-Browser-Core-Browsers',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'Browsers'
}

{ #category : 'testing' }
ViennaStateVariableReferenceListPresenter class >> isAbstract [

	^ self == ViennaStateVariableReferenceListPresenter
]

{ #category : 'private' }
ViennaStateVariableReferenceListPresenter >> createGlobalNames [

	| last |
	last := nil.
	^ Array streamContents: [ :stream |
			  targetName ifNotNil: [ :target |
					  self specification ifNotNil: [ :specification |
							  targetName module ifNotNil: [ :module |
									  module allDescendantsSuchThat: [ :node | node isViennaNameNode and: [ node isStateVariableNameNode ] ] do: [ :node |
											  ((targetName identifier isNil or: [ targetName identifier = node identifier ]) and: [ self check: node ]) ifTrue: [
													  node topLevelDefinition ifNotNil: [ :def |
															  def globalNamesDo: [ :globalName |
																	  last ~= globalName ifTrue: [
																			  stream nextPut: globalName.
																			  last := globalName ] ] ] ] ] ] ] ] ]
]
