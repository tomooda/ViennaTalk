Class {
	#name : 'ViennaFRAMAnnotationParser',
	#superclass : 'PP2CompositeNode',
	#category : 'ViennaTalk-FRAM-Core',
	#package : 'ViennaTalk-FRAM-Core'
}

{ #category : 'parsing' }
ViennaFRAMAnnotationParser >> framAnnotation [

	^ 'FRAM' asPParser , #blank asPParser plus
	  , #letter asPParser plus trim , #any asPParser star flatten
	  ==> [ :quad | 
		  { 
			  quad third first asLowercase.
			  quad fourth trim } ]
]

{ #category : 'parsing' }
ViennaFRAMAnnotationParser >> start [

	^ self framAnnotation
]
