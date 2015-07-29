instance creation
bank: anInteger
	| bank |
	bank := ViennaBankEngine new.
	anInteger timesRepeat: [ bank add: self new ].
	^ bank