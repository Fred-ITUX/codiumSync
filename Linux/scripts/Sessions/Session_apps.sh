#!/bin/bash

nextcloud(){
    flatpak run com.nextcloud.desktopclient.nextcloud &
}

brave(){
    flatpak run com.brave.Browser &
}

steam(){
    flatpak run com.valvesoftware.Steam -silent &
}


chrome_full(){

    tabTimeOut="10s"

    gmail="https://mail.google.com/mail/u/"
    flatpak run com.google.Chrome https://music.youtube.com/ &
    sleep "$tabTimeOut"
    flatpak run com.google.Chrome "$gmail"0 &
    sleep "$tabTimeOut"
    flatpak run com.google.Chrome "$gmail"1 &
    sleep "$tabTimeOut"
    flatpak run com.google.Chrome "$gmail"2 &
    sleep "$tabTimeOut"
    flatpak run com.google.Chrome "$gmail"3 &
    sleep "$tabTimeOut"
    flatpak run com.google.Chrome "$gmail"4 &
}


vsCodium(){
    flatpak run com.vscodium.codium &
}