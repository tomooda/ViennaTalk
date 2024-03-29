#!/bin/bash
mkdir viennatalk
cd viennatalk
curl -k -L https://get.pharo.org/64/110+vm | bash
./pharo Pharo.image metacello install github://tomooda/ViennaTalk:main BaselineOfViennaTalk
cat <<EOF > viennatalk
#!/bin/bash
cd \$(dirname \$0)
./pharo-ui Pharo.image
EOF
chmod a+rx viennatalk
echo "install done. please add "$PWD" to your PATH env var."
