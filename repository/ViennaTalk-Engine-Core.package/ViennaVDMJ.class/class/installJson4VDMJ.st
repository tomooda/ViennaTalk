class initialization
installJson4VDMJ
	"ViennaVDMJ installJson4VDMJ"

	(self proceed: 'Do you want to download Json4VDMJ?' title: 'Installing Json4VDMJ')
		ifTrue: [ 
			(self proceed: self aboutJson4VDMJ title: 'Json4VDMJ Copyright Notice')
				ifTrue: [ 
					| http |
					http := ZnClient new.
					http
						beOneShot;
						https;
						followRedirects: true;
						get: self json4vdmjUrl.
					http response code = 200
						ifFalse: [ 
							UIManager default
								abort: 'Failed to download Json4VDMJ. Please download from http://vdmpad.csce.kyushu-u.ac.jp/Json4VDMJ.jar .'.
							^ nil ].
					self json4vdmjPath writeStream
						nextPutAll: http entity bytes;
						close ] ]