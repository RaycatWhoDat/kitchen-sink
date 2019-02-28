#!/bin/sh
 
set -uexo pipefail

ENV="$(realpath ~/.tcl)"

mkdir -p "$ENV/bin"

curl https://www.fossil-scm.org/index.html/uv/fossil-linux-x64-2.8.tar.gz | tar -C "$ENV/bin" -xvf -
curl https://chiselapp.com/user/aspect/repository/sdx/uv/sdx-20110317.kit > "$ENV/bin/sdx"
curl https://www.rkeene.org/devel/kitcreator/kitbuild/nightly/tclkit-8.6.9-linux-amd64-notk > "$ENV/bin/tclkit"
chmod +x "$ENV"/bin/*
 
PATH="$PATH:$ENV/bin"
export PATH
 
mkdir "$ENV/src"
cd "$ENV/src"
fossil clone http://teaparty.rkeene.org/fossil/index teaparty.fossil
mkdir teaparty
cd teaparty
fossil open ../teaparty.fossil
make client/teapot-client.kit
cp client/teapot-client.kit "$ENV/bin/teapot-client"

chmod +x "$ENV/bin/teapot-client"
