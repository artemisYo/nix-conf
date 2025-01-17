#! /bin/sh

git add .

sudo nixos-rebuild --impure --flake ./ switch || exit 1

counter=`cat .counter`
((counter=counter+1))

echo "$counter" > .counter

git add .counter
git add flake.lock
git commit -m "$counter"
