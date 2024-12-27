Class {
	#name : 'ViennaAbstractNodeChange',
	#superclass : 'Object',
	#instVars : [
		'from',
		'to',
		'sourceDiffText'
	],
	#category : 'ViennaTalk-Browser-Core-Diff',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'Diff'
}

{ #category : 'utilities' }
ViennaAbstractNodeChange class >> flushSourceDiffText [

	<script: 'self flushSourceDiffText'>
	self allSubclassesDo: [ :c |
		c allInstancesDo: [ :i | i flushSourceDiffText ] ]
]

{ #category : 'instance creation' }
ViennaAbstractNodeChange class >> from: aViennaNode to: anotherViennaNode [

	^ self new
		  setFrom: aViennaNode to: anotherViennaNode;
		  yourself
]

{ #category : 'copying' }
ViennaAbstractNodeChange >> , aViennaAbstractNodeChange [

	^ (self class = aViennaAbstractNodeChange class and: [
		   to = aViennaAbstractNodeChange from ]) ifTrue: [
		  self class from: self from to: aViennaAbstractNodeChange to ]
]

{ #category : 'enumerating' }
ViennaAbstractNodeChange >> changedGlobalNamesDo: aBlock [

	^ self subclassResponsibility
]

{ #category : 'private' }
ViennaAbstractNodeChange >> flushSourceDiffText [

	sourceDiffText := nil
]

{ #category : 'accessing' }
ViennaAbstractNodeChange >> from [

	^ from
]

{ #category : 'testing' }
ViennaAbstractNodeChange >> isViennaModuleNodeChange [

	^ false
]

{ #category : 'testing' }
ViennaAbstractNodeChange >> isViennaTopLevelDefinitionNodeChange [

	^ false
]

{ #category : 'testing' }
ViennaAbstractNodeChange >> overwrites: aViennaAbstractNodeChange [

	^ self class = aViennaAbstractNodeChange class and: [
		  from = aViennaAbstractNodeChange to ]
]

{ #category : 'printing' }
ViennaAbstractNodeChange >> printNames [

	^ String streamContents: [ :stream | self printNamesOn: stream ]
]

{ #category : 'printing' }
ViennaAbstractNodeChange >> printNamesOn: aStream [

	^ self subclassResponsibility
]

{ #category : 'printing' }
ViennaAbstractNodeChange >> printSummary [

	^ String streamContents: [ :stream | self printSummaryOn: stream ]
]

{ #category : 'printing' }
ViennaAbstractNodeChange >> printSummaryOn: aStream [

	from
		ifNil: [ to ifNotNil: [ aStream nextPutAll: 'added' ] ]
		ifNotNil: [
			to
				ifNil: [ aStream nextPutAll: 'removed' ]
				ifNotNil: [ aStream nextPutAll: 'modified' ] ]
]

{ #category : 'private' }
ViennaAbstractNodeChange >> setFrom: aViennaNode to: anotherViennaNode [

	from := aViennaNode.
	to := anotherViennaNode
]

{ #category : 'printing' }
ViennaAbstractNodeChange >> sourceDiffText [

	^ sourceDiffText ifNil: [
		  | diffMap source |
		  from ifNil: [
			  ^ to highlightedSource
				    addAttribute: TextEmphasis underlined;
				    yourself ].
		  to ifNil: [
			  ^ from highlightedSource
				    addAttribute: TextEmphasis struckOut;
				    yourself ].
		  diffMap := IdentityDictionary new.
		  to
			  diffFrom: from
			  changesDo: [ :toNode :fromNodes |
			  diffMap at: toNode put: fromNodes ].
		  source := to tracingHighlightedSource.
		  diffMap keysAndValuesDo: [ :toNode :fromNodes |
			  (source string intervalForSource: toNode) key ifNotEmpty: [
				  :interval |
				  source := (source copyFrom: 1 to: interval first - 1)
				            , ((toNode parent listDelimiter join:
							              (fromNodes collect: [ :fromNode |
									               fromNode source ])) asText
						             addAttribute: TextEmphasis struckOut;
						             yourself)
				            , (toNode ifNotEmpty: [ ' ' ] ifEmpty: [ '' ])
				            ,
					            ((source copyFrom: interval first to: interval last)
						             addAttribute: TextEmphasis underlined)
				            , (source copyFrom: interval last + 1 to: source size) ] ].
		  sourceDiffText := source string asString asString asText
			                    runs: source runs;
			                    yourself ]
]

{ #category : 'accessing' }
ViennaAbstractNodeChange >> to [

	^ to
]
