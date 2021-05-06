# BARBERSHOP 1.1

## Local development setup:

IMPORTANT: This application runs on Ruby 2.7.2

In the following instructions it's explained how to install Ruby and Rails to launch this app in a web server named Puma, which comes bundled with Rails. In Linux/UNIX or Mac OS/X you can use the package management system of your distribution such as RVM, as we are going to explain. **In every step that shows two commands, the first one is for Mas OS and the second one for Debian or Ubuntu. If you are on Windows you can jump directly to step 5**, because you have to use donwloadable installers, which you'll be provided with the links.

The following instruction are better explained in:

* https://nrogap.medium.com/install-rvm-in-macos-step-by-step-d3b3c236953b

* https://www.phusionpassenger.com/library/walkthroughs/deploy/ruby/ownserver/nginx/oss/install_language_runtime.html

* https://guides.rubyonrails.org/v5.0/getting_started.html

IMPORTANT: If you are in Mac OS X, you'll need to have Homebrew installed as a prerequisite.

If you are in Windows, go directly to 

* 1)Install GnuPG:
```
brew install gnupg
```
In Debian or Ubuntu:
```
sudo apt-get update
sudo apt-get install -y curl gnupg build-essential
```

* 2)Install GPG Keys
```
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
```
```
sudo gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
```

* 3)Install RVM
```
\curl -sSL https://get.rvm.io | bash
```
```
curl -sSL https://get.rvm.io | sudo bash -s stable
sudo usermod -a -G rvm `whoami`
```

If you've done it successfully you will recieve a Thank You! message in the console.

* 4)After this you have to quit the terminal al reopen it. To check if RVM is conrrectly installed run:
```
rvm list
```

If you get the message
```
No rvm rubies installed yet. Try 'rvm help install'.
```

everything's alright!

* 5)Install Ruby 2.7.2
```
rvm install 2.7.2
```

and check 
```
rvm list
```

In Windows download the [Ruby Installer](https://rubyinstaller.org/downloads/).

If it shows something like the following, everything's fine
```
#ruby-2.7.1 [ x86_64 ]
```

* 6)FOR MAC OS: Create Ruby default version

```
rvm alias create default 2.7.2
```

* 7)Now we are going to install Rails:
```
gem install rails
```
To check if it installed correctly run
```
rails --version
```

* 8)Finally, we must install Node.js. This is because Rails's asset pipeline compiler requires a Javascript runtime. The Node.js version does not matter. You can use an installer no matter which OS you are running. **In Windows that´s your only choice** and you can donload it [here](https://nodejs.org/en/download/). In Mac OS or Ubuntu/Debian you can use the following commands:
```
brew install node
```
```
sudo apt install nodejs
```


To check version 
```
node -v
```

You now must be able to run the project in localhost by running the following command from the project folder
```
rails server
```
It defaults to the port 3000. If you want to open it in a specific port instead run
```
rails s -p XXXX
```

## Santiago Paul
## Matias Baeza Graf
## 2021
