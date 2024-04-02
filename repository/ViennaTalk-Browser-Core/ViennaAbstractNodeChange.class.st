Class {
	#name : #ViennaAbstractNodeChange,
	#superclass : #Object,
	#instVars : [
		'from',
		'to',
		'sourceDiffText'
	],
	#category : #'ViennaTalk-Browser-Core-Diff'
}

{ #category : #utilities }
ViennaAbstractNodeChange class >> flushSourceDiffText [

	<script: 'self flushSourceDiffText'>
	self allSubclassesDo: [ :c |
		c allInstancesDo: [ :i | i flushSourceDiffText ] ]
]

{ #category : #'instance creation' }
ViennaAbstractNodeChange class >> from: aViennaNode to: anotherViennaNode [

	^ self new
		  setFrom: aViennaNode to: anotherViennaNode;
		  yourself
]

{ #category : #private }
ViennaAbstractNodeChange >> flushSourceDiffText [

	sourceDiffText := nil
]

{ #category : #accessing }
ViennaAbstractNodeChange >> from [

	^ from
]

{ #category : #printing }
ViennaAbstractNodeChange >> printNames [

	^ String streamContents: [ :stream | self printNamesOn: stream ]
]

{ #category : #printing }
ViennaAbstractNodeChange >> printNamesOn: aStream [

	^ self subclassResponsibility
]

{ #category : #printing }
ViennaAbstractNodeChange >> printSummary [

	^ String streamContents: [ :stream | self printSummaryOn: stream ]
]

{ #category : #printing }
ViennaAbstractNodeChange >> printSummaryOn: aStream [

	from
		ifNil: [ to ifNotNil: [ aStream nextPutAll: 'added' ] ]
		ifNotNil: [
			to
				ifNil: [ aStream nextPutAll: 'removed' ]
				ifNotNil: [ aStream nextPutAll: 'modified' ] ]
]

{ #category : #private }
ViennaAbstractNodeChange >> setFrom: aViennaNode to: anotherViennaNode [

	from := aViennaNode.
	to := anotherViennaNode
]

{ #category : #printing }
ViennaAbstractNodeChange >> sourceDiffText [

	^ sourceDiffText ifNil: [
		  | diffMap source |
		  from ifNil: [
			  ^ to highlightedSource
				    addAttribute: TextEmphasis bold;
				    yourself ].
		  to ifNil: [
			  ^ from highlightedSource
				    addAttribute: TextEmphasis struckOut;
				    yourself ].
		  diffMap := IdentityDictionary new.
		  to
			  diffFrom: from
			  changesDo: [ :toNode :fromNode |
			  diffMap at: toNode put: fromNode ].
		  source := to tracingHighlightedSource.
		  diffMap keysAndValuesDo: [ :toNode :fromNode |
			  (source string intervalForSource: toNode) key ifNotEmpty: [
				  :interval |
				  source := (source copyFrom: 1 to: interval first - 1)
				            , (fromNode source asText
						             addAttribute: TextEmphasis struckOut;
						             yourself)
				            ,
					            ((source copyFrom: interval first to: interval last)
						             addAttribute: TextEmphasis underlined)
				            , (source copyFrom: interval last + 1 to: source size) ] ].
		  sourceDiffText := source string asString asString asText
			                    runs: source runs;
			                    yourself ]
]

{ #category : #accessing }
ViennaAbstractNodeChange >> to [

	^ to
]
