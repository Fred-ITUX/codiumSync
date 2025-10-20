#!/bin/bash

gpuA(){
    flatpak override --user --device=dri
}
gpuA com.google.Chrome
gpuA com.brave.Browser
gpuA com.valvesoftware.Steam
gpuA com.discordapp.Discord