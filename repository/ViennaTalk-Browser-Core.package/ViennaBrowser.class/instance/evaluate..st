private
evaluate: aString 
	^ self evaluate: aString ifError: [ :msg | msg ]