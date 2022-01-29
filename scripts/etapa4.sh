#aplica temas
gsettings set org.gnome.desktop.interface gtk-theme "Arc-Darker"
gsettings set org.gnome.desktop.wm.preferences theme "Arc"
gsettings set org.gnome.desktop.interface icon-theme "Arc" 
#atualiza .bashrc
sudo wget https://github.com/gsuzeda/easygentoo/blob/main/files/.bashrc -O ~/.bashrc
source ~/.bashrc
#Instala o Android SDK
wget https://dl.google.com/android/repository/commandlinetools-linux-7583922_latest.zip -O commandline.zip
unp commandline.zip
mkdir -p ~/Android/Sdk/cmdline-tools/latest
mv ~/cmdline-tools/*  ~/Android/Sdk/cmdline-tools/latest/
rm commandline.zip -rf cmdline-tools
sdkmanager --update
yes | sdkmanager --licenses
sdkmanager "platforms;android-32" "build-tools;32.0.0" "extras;google;m2repository" "extras;android;m2repository" "platform-tools" "tools" "ndk;23.1.7779620" "cmake;3.6.4111459"

#Instala o flutter
wget https://storage.googleapis.com/flutter_infra_release/releases/beta/linux/flutter_linux_2.9.0-0.1.pre-beta.tar.xz -O ~/Android/flutter.tar.xz
unp ~/Android/flutter.tar.xz
mv flutter ~/Android/flutter
flutter upgrade
#Potato Sources
 git config --global user.email "gabrielsuzeda@gmail.com"
 git config --global user.name "Uzeda"

#Android rules
sudo curl --create-dirs -L -o /etc/udev/rules.d/51-android.rules -O -L https://raw.githubusercontent.com/M0Rf30/android-udev-rules/master/51-android.rules
sudo chmod 644 /etc/udev/rules.d/51-android.rules
sudo chown root /etc/udev/rules.d/51-android.rules
sudo systemctl restart udev


