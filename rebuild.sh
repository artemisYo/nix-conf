#! /bin/sh

git add .

counter=`cat .counter`
((counter=counter+1))

git commit -m "$counter"

echo "$counter" > .counter

sudo nixos-rebuild --impure --flake ./ switch
