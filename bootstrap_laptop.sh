#!/bin/sh

echo "---------------------------------"
echo "    Nick's dotfiles"
echo "               -> extra bootstrap"
echo ""
echo " ... starting extra config now..."
echo "---------------------------------"

echo " --> Installing power stuff..."
sudo pacman -S tlp thermald

echo ""
echo ""
echo ""

echo " --> Enabling services..."
sudo systemctl enable tlp
sudo systemctl enable thermald

echo ""    
echo ""
echo ""

echo " --> Calibrating with powertop..."
sudo powertop -c

echo ""    
echo ""
echo ""

echo "OK. Extra setup should be done."
