# Installation
To prepare to run tests on a headless server:
```
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt update
sudo apt install google-chrome-stable
sudo apt install xvfb
Xvfb :0 -screen 0 1280x960x24
```

Now install xvfb as a service by creating `/etc/systemd/system/xvfb.service`:
```
[Unit]
Description=X Virtual Frame Buffer Service
After=network.target

[Service]
ExecStart=/usr/bin/Xvfb :0 -screen 0 1280x960x24

[Install]
WantedBy=multi-user.target
```
[Source](https://askubuntu.com/a/621256)

And then run:
```
sudo systemctl enable /etc/systemd/system/xvfb.service
```

At which point you can:
```
sudo systemctl start xvfb
```
