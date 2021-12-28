#!/bin/sh

#  pre_compile.sh
#  InterestAroundMe
#
#  Created by Kamaal M Farah on 28/12/2021.
#  

if which swiftlint >/dev/null; then
  swiftlint
else
  echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi
