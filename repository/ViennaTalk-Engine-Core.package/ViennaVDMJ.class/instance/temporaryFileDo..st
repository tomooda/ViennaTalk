private
temporaryFileDo: aBlock
	| random file stream |
	random := Random new.
	self
		globalLock: [ 
			[ 
			file := FileSystem workingDirectory / 'VDMPad-spec-'
				, (String withAll: ((1 to: 8) collect: [ :i | '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ' at: (random nextInt: 36) ]))
				, '.vdm'.
			file exists ] whileTrue.
			stream := file writeStream.
			[ aBlock value: stream ]
				ensure: [ 
					stream close.
					file deleteIfAbsent: [  ] ] ]