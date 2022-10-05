#Configura o git
 git config --global user.email "gabrielsuzeda@gmail.com"
 git config --global user.name "Uzeda"

cd ~/
#atualiza .bashrc
sudo wget https://raw.githubusercontent.com/gsuzeda/easygentoo/main/files/.bashrc?token=GHSAT0AAAAAABRIMFYB6CLQL3UFJYSGREU2YQHE3BA -O ~/.bashrc
source ~/.bashrc
#Instala o Android SDK
wget https://dl.google.com/android/repository/commandlinetools-linux-8092744_latest.zip -O commandline.zip
unzip commandline.zip
mkdir -p ~/Android/Sdk/cmdline-tools/latest
mv ~/cmdline-tools/*  ~/Android/Sdk/cmdline-tools/latest/
rm commandline.zip -rf cmdline-tools
export PATH=~/Android/Sdk/platform-tools:$PATH
export PATH=~/Android/Sdk/cmdline-tools/latest/bin:$PATH
sdkmanager --update
yes | sdkmanager --licenses
sdkmanager "platforms;android-32" "build-tools;32.0.0" "extras;google;m2repository" "extras;android;m2repository" "platform-tools" "tools" "ndk;23.1.7779620" "cmake;3.6.4111459"

#Instala o flutter
wget https://storage.googleapis.com/flutter_infra_release/releases/beta/linux/flutter_linux_2.9.0-0.1.pre-beta.tar.xz -O ~/Android/flutter.tar.xz
tar -xf ~/Android/flutter.tar.xz
mv flutter ~/Android/flutter
export PATH=~/Android/flutter/bin:$PATH
flutter upgrade

#Android rules
sudo curl --create-dirs -L -o /etc/udev/rules.d/51-android.rules -O -L https://raw.githubusercontent.com/M0Rf30/android-udev-rules/master/51-android.rules
sudo chmod 644 /etc/udev/rules.d/51-android.rules
sudo chown root /etc/udev/rules.d/51-android.rules
sudo systemctl restart udev

#otimizando algumas coisas, sim, causará erros de dep. So rodar o comando dnv quando atualizar
#sudo emerge --unmerge sys-apps/hwloc cups  app-text/mupdf

#Remove o Evolution Data Server
sudo chmod -x /usr/lib/evolution/evolution-calendar-factory
sudo mv /usr/lib/evolution-data-server /usr/lib/evolution-data-server-disabled
sudo mv /usr/lib/evolution /usr/lib/evolution-disabled
systemctl --user mask evolution-addressbook-factory.service evolution-calendar-factory.service evolution-source-registry.service

