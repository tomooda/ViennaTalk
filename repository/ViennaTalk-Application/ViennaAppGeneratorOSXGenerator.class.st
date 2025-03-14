Class {
	#name : 'ViennaAppGeneratorOSXGenerator',
	#superclass : 'AppGeneratorOSXGenerator',
	#category : 'ViennaTalk-Application',
	#package : 'ViennaTalk-Application'
}

{ #category : 'external resources' }
ViennaAppGeneratorOSXGenerator >> addExternalDirectory: origin destination: destination [

	externalResources add: (AppGeneratorFileResource new
			 generator: self;
			 origin: origin asFileReference;
			 destination: destination;
			 beDirectory;
			 yourself)
]

{ #category : 'external resources' }
ViennaAppGeneratorOSXGenerator >> addExternalFile: origin destination: destination [

	externalResources add: (AppGeneratorFileResource new
			 generator: self;
			 origin: origin asFileReference;
			 destination: destination;
			 yourself)
]

{ #category : 'scripts' }
ViennaAppGeneratorOSXGenerator >> buildScriptTemplate [

	^ '#!/bin/bash

set -x 
set -e

IMAGE_DIR={ImageDir}
IMAGE_NAME={ImageName}
CHANGES_NAME={ChangesName}
APP_NAME={AppName}
APP_BUNDLE=$APP_NAME.app
VM_TYPE={VMType}

# To create the DMG we need the create-dmg tool, you can get it from brew
# brew install create-dmg

#Clean Up previous build
rm -f *.dmg

mkdir -p $APP_BUNDLE/Contents/Resources/

cp -f $IMAGE_DIR/*.sources $APP_BUNDLE/Contents/Resources/
cp -f $IMAGE_DIR/$CHANGES_NAME $APP_BUNDLE/Contents/Resources/
cp -f $IMAGE_DIR/$IMAGE_NAME $APP_BUNDLE/Contents/Resources/

#Downloading Pharo VM
if [ ! -d "./pharo-vm-arm64" ] 
then
        mkdir pharo-vm-arm64
    pushd pharo-vm-arm64
    if [ $VM_TYPE -eq "headless" ]; then
      curl --output vm.zip https://files.pharo.org/vm/pharo-spur64-headless/$(uname -s)-arm64/{VMZipFile}
    else
      curl --output vm.zip https://files.pharo.org/vm/pharo-spur64/$(uname -s)-arm64/stable10.zip
    fi
    unzip vm.zip 
    popd
fi
if [ ! -d "./pharo-vm-x86_64" ] 
then
        mkdir pharo-vm-x86_64
    pushd pharo-vm-x86_64
    if [ $VM_TYPE -eq "headless" ]; then
      curl --output vm.zip https://files.pharo.org/vm/pharo-spur64-headless/$(uname -s)-x86_64/{VMZipFile}
    else
      curl --output vm.zip https://files.pharo.org/vm/pharo-spur64/$(uname -s)-x86_64/stable10.zip
    fi
    unzip vm.zip 
    popd
fi

rm -f pharo-vm
ln -s pharo-vm-$(uname -m) pharo-vm

pharo-vm/Pharo.app/Contents/MacOS/Pharo --headless $APP_BUNDLE/Contents/Resources/$IMAGE_NAME eval --save {DeployPharoExpression}

#Setting DPI for the background image
sips --setProperty dpiWidth 144 --setProperty dpiHeight 144 installer-background.png

#Creating DMG
for ARCH in arm64 x86_64; do
  rm -f -R dmg
  mkdir -p dmg
  cp -r $APP_BUNDLE ./dmg/
  mkdir -p ./dmg/$APP_BUNDLE/Contents/MacOS
  cp -Rf pharo-vm-$ARCH/Pharo.app/Contents/MacOS/* ./dmg/$APP_BUNDLE/Contents/MacOS/
  codesign --force --deep -s {CodesignName} dmg/$APP_BUNDLE
  create-dmg \\
    --volname "$APP_NAME Installer" \\
    --volicon "installer.icns" \\
    --background "installer-background.png" \\
    --window-pos 200 120 \\
    --window-size 600 400 \\
    --icon-size 100 \\
    --icon "$APP_BUNDLE" 120 120 \\
    --hide-extension "$APP_BUNDLE" \\
    --app-drop-link 450 120 \\
    "$APP_NAME-Installer-mac-$ARCH.dmg" \\
    "dmg/"
done
if [ ! -d "./$APP_NAME-windows" ] 
then
    mkdir -p $APP_NAME-windows/Pharo
    pushd $APP_NAME-windows
    echo ".\Pharo\Pharo.exe .\$APP_NAME.image" > $APP_NAME.bat
    cp -rp ../$APP_NAME.app/Contents/Resources/pharo-local .
    cd Pharo
    if [ $VM_TYPE -eq "headless" ]; then
      curl --output vm.zip https://files.pharo.org/vm/pharo-spur64-headless/Windows-x86_64/latest10.zip
    else
      curl --output vm.zip https://files.pharo.org/vm/pharo-spur64/Windows-x86_64/stable10.zip
    fi
    unzip vm.zip
    rm vm.zip
    popd
fi

rm -rf $APP_NAME
cp -rp $APP_NAME-windows $APP_NAME
cp $APP_NAME.app/Contents/Resources/$APP_NAME.image $APP_NAME/
cp $APP_NAME.app/Contents/Resources/$APP_NAME.changes $APP_NAME/
cp $APP_NAME.app/Contents/Resources/*.sources $APP_NAME/
rm -f $APP_NAME-win-x64.zip
zip -r $APP_NAME-win-x64.zip $APP_NAME
' withUnixLineEndings
]

{ #category : 'external resources' }
ViennaAppGeneratorOSXGenerator >> externalResourceTargetDirectory [

	^ outputDirectory / (self appName , '.app') / 'Contents' / 'Resources'
]

{ #category : 'utilities' }
ViennaAppGeneratorOSXGenerator >> fillWithDefaults [

	super fillWithDefaults.
	properties
		at: #DeployPharoExpression ifAbsentPut: 'nil';
		at: #CodesignName ifAbsentPut: '-'
]

{ #category : 'generating' }
ViennaAppGeneratorOSXGenerator >> generateBuildScript [

	self
		copyTemplate: self buildScriptTemplate readStream
		to: outputDirectory / 'build.sh'
]
