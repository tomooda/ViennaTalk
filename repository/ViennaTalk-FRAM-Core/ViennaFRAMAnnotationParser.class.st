Class {
	#name : #ViennaFRAMAnnotationParser,
	#superclass : #PP2CompositeNode,
	#category : #'ViennaTalk-FRAM-Core'
}

{ #category : #parsing }
ViennaFRAMAnnotationParser >> framAnnotation [

	^ 'FRAM' asPParser trim , #letter asPParser plus trim , #any asPParser star flatten
	  ==> [ :triple | 
		  { 
			  triple second first asLowercase.
			  triple third trim } ]
]

{ #category : #parsing }
ViennaFRAMAnnotationParser >> start [

	^ self framAnnotation
]
