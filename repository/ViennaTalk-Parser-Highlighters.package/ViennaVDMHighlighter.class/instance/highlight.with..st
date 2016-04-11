utilities
highlight: aParser with: aTextAttributeOrCollection
	^ aParser
		=>> [ :start :end :result | 
			aTextAttributeOrCollection isCollection
				ifTrue: [ aTextAttributeOrCollection do: [ :attribute | text addAttribute: attribute from: start to: end ] ]
				ifFalse: [ text addAttribute: aTextAttributeOrCollection from: start to: end ].
			result ]