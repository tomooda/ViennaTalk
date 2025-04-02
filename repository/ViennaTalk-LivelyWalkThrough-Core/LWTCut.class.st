Class {
	#name : 'LWTCut',
	#superclass : 'Object',
	#instVars : [
		'frames',
		'remark'
	],
	#category : 'ViennaTalk-LivelyWalkThrough-Core',
	#package : 'ViennaTalk-LivelyWalkThrough-Core'
}

{ #category : 'instance creation' }
LWTCut class >> frames: aCollectionOfLWTFrame [ 
	^ self remark: Text new frames: aCollectionOfLWTFrame
]

{ #category : 'instance creation' }
LWTCut class >> remark: aText frames: aCollectionOfLWTFrame [ 
	^ self new remark: aText;
		 frames: aCollectionOfLWTFrame;
		 yourself
]

{ #category : 'adding' }
LWTCut >> addFrame: anLWTFrame [ 
	frames := (frames asSet add: anLWTFrame;
				
				asSortedCollection: [:less :more | less timestamp <= more timestamp]) asArray.
	^ anLWTFrame
]

{ #category : 'adding' }
LWTCut >> addFrames: aCollectionOfLWTFrame [ 
	frames := (frames asSet addAll: aCollectionOfLWTFrame;
				
				asSortedCollection: [:less :more | less timestamp <= more timestamp]) asArray.
	^ aCollectionOfLWTFrame
]

{ #category : 'accessing' }
LWTCut >> frames [
	^ frames
]

{ #category : 'accessing' }
LWTCut >> frames: aCollectionOfLWTFrame [ 
	frames := (aCollectionOfLWTFrame
				asSortedCollection: [:less :more | less timestamp <= more timestamp]) asArray
]

{ #category : 'initialize-release' }
LWTCut >> initialize [
	super initialize.
	remark := Text new.
	frames := Array new
]

{ #category : 'accessing' }
LWTCut >> remark [
	^ remark
]

{ #category : 'accessing' }
LWTCut >> remark: aText [
	remark := aText
]

{ #category : 'removing' }
LWTCut >> removeFrame: anLWTFrame [ 
	frames := frames copyWithout: anLWTFrame.
	^ anLWTFrame
]

{ #category : 'removing' }
LWTCut >> removeFrames: aCollectionOfLWTFrame [ 
	frames := frames copyWithoutAll: aCollectionOfLWTFrame.
	^ aCollectionOfLWTFrame
]
