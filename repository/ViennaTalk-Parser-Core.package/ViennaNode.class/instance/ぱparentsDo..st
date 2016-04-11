enumerating
ぱparentsDo: aBlock
	| node |
	node := self.
	[ node notNil ]
		whileTrue: [ 
			aBlock value: node.
			node := node parent ]