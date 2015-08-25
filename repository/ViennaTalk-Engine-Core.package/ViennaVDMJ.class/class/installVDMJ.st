class initialization
installVDMJ
	"ViennaVDMJ installVDMJ"

	(self proceed: 'Do you want to download VDMJ?' title: 'Installing VDMJ')
		ifTrue: [ 
			(self proceed: self aboutVDMJ title: 'VDMJ Copyright Notice')
				ifTrue: [ 
					| http |
					http := ZnClient new.
					http
						beOneShot;
						https;
						followRedirects: true;
						get: self vdmjUrl.
					http response code = 200
						ifFalse: [ 
							UIManager default
								abort:
									'Failed to download VDMJ. Please download from https://github.com/nickbattle/vdmj/releases and place it at $PHARO/Contents/Resources/ .'.
							^ nil ].
					self vdmjPath writeStream
						nextPutAll: http entity bytes;
						close ] ]