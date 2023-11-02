# Vagrant virual machine with clean centos-8

Your need install vagrant and virtualbox for up this configuration.

Your need install [vagrant](https://github.com/hashicorp/vagrant-installers/releases/tag/v2.3.4.dev%2Bmain "vagrant") and  [virtualbox](https://www.virtualbox.org/ "virtualbox") for up this configuration. Optional you can use [make](https://www.gnu.org/software/make/ "make").

### Step 1

Download box bento/centos-8 for virtualbox from [vagrantup](https://app.vagrantup.com/bento/boxes/centos-8 "vagrantup").

### Step 2

Clonr this repository: git clone https://github.com/codesshaman/vagrant_centos_8.git

### Step 3

Copy box and go inside the repository folder:

``cp ~/Downloads/913d42c0-8cbe-4beb-98b7-668a670ef707 path_to/vagrant_centos_8/centos``

``cd vagrant_centos_8``

### Step 4

Inicialize configuration:

``vagrant box add bento/centos-8 centos``

or with make:

``make build``

### Step 5

Install configuration:

``vagrant up --provider=virtualbox``

or with make:

``make``

### Step 6

Connect:

``ssh vagrant@192.168.58.88``

or with make:

``make connect``
