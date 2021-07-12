#!/bin/zsh

echo "Make sure Swift is installed."
echo "Building Temp..."

swift build -c release --package-path TempPackage
echo "Built Temp. Moving temp to ../"
mv TempPackage/.build/release/temp .
