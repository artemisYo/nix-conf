#! /bin/sh

git add .

sudo nixos-rebuild --impure --flake ./ switch

git add flake.lock

counter=`cat .counter`
((counter=counter+1))

echo "$counter" > .counter

git commit -m "$counter"
