Class {
	#name : 'ViennaFRAMVDMAnnotationParser',
	#superclass : 'PP2CompositeNode',
	#category : 'ViennaTalk-FRAM-Core',
	#package : 'ViennaTalk-FRAM-Core'
}

{ #category : 'parsing' }
ViennaFRAMVDMAnnotationParser >> followingLetter [

	^ PP2PredicateObjectNode
		  on: [ :c | ViennaUnicode isFollowingLetter: c ]
		  message: 'identifier expected'
]

{ #category : 'parsing' }
ViennaFRAMVDMAnnotationParser >> identifier [

	^ (self initialLetter , self followingLetter starA) flatten ==> [ :str | 
	  ((self prefixes anySatisfy: [ :p | 
		    str size >= p size and: [ 
			    (1 to: p size) allSatisfy: [ :i | (str at: i) = (p at: i) ] ] ]) 
		   or: [ self keywords includes: str ])
		  ifTrue: [ 
			  PP2Failure message:
				  'a keyword or prefixed word can not be an identifier' ]
		  ifFalse: [ str ] ]
]

{ #category : 'parsing' }
ViennaFRAMVDMAnnotationParser >> initialLetter [

	^ PP2PredicateObjectNode
		  on: [ :c | ViennaUnicode isInitialLetter: c ]
		  message: 'identifier expected'
]

{ #category : 'parsing' }
ViennaFRAMVDMAnnotationParser >> keywords [

	^ #( 'all' 'always' 'and' 'as' 'async' 'atomic' 'be' 'bool' 'by' 'card'
	     'cases' 'char' 'class' 'comp' 'compose' 'conc' 'cycles' 'dcl'
	     'def' 'definitions' 'dinter' 'div' 'dlmodule' 'do' 'dom' 'dunion'
	     'duration' 'elems' 'else' 'elseif' 'end' 'error' 'errs' 'exists'
	     'exists1' 'exit' 'exports' 'ext' 'false' 'floor' 'for' 'forall'
	     'from' 'functions' 'hd' 'if' 'in' 'inds' 'inmap' 'instance'
	     'int' 'inter' 'imports' 'init' 'inv' 'inverse' 'iota' 'is' 'isofbaseclass'
	     'isofclass' 'lambda' 'len' 'let' 'map' 'measure' 'merge' 'mod'
	     'module' 'mu' 'munion' 'mutex' 'nat' 'nat1' 'new' 'nil' 'not'
	     'of' 'operations' 'or' 'others' 'per' 'periodic' 'post' 'power'
	     'pre' 'pre_' 'private' 'protected' 'psubset' 'public' 'pure'
	     'rat' 'rd' 'real' 'rem' 'renamed' 'responsibility'
	     'return' 'reverse' 'rng' 'samebaseclass' 'sameclass' 'self'
	     'seq' 'seq1' 'set' 'set1' 'skip' 'specified' 'sporadic'
	     'st' 'start' 'startlist' 'state' 'stop' 'stoplist' 'struct'
	     'subclass' 'subset' 'sync' 'system' 'then' 'thread' 'threadid'
	     'time' 'tixe' 'tl' 'to' 'token' 'traces' 'trap' 'true' 'types'
	     'undefined' 'union' 'uselib' 'values' 'variables' 'while'
	     'with' 'wr' 'yet' 'RESULT' )
]

{ #category : 'parsing' }
ViennaFRAMVDMAnnotationParser >> prefixes [
	^ #('mk_' 'is_' 'obj_' 'narrow_')
]

{ #category : 'accessing' }
ViennaFRAMVDMAnnotationParser >> start [

	^ self vdmAnnotation
]

{ #category : 'parsing' }
ViennaFRAMVDMAnnotationParser >> vdmAnnotation [

	^ self vdmGlobalNameAnnotation / self vdmShortNameAnnotation
]

{ #category : 'parsing' }
ViennaFRAMVDMAnnotationParser >> vdmGlobalNameAnnotation [

	^ '@VDM' asPParser , #blank asPParser plus
	  , (self identifier , $` asPParser trim , self identifier
		   ==> [ :triple | 
			   { 
				   triple first.
				   triple third } ]) trimBlanks ==> #third
]

{ #category : 'parsing' }
ViennaFRAMVDMAnnotationParser >> vdmShortNameAnnotation [

	^ '@VDM' asPParser , #blank asPParser plus
	  , self identifier trimBlanks ==> #third
]
