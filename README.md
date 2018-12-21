# ArcLight Prototype Application

This repository contains a minimal [ArcLight](https://github.com/sul-dlss/arclight)
Rails application. It was created using the Arclight generator, as described in
[Getting started: creating a new ArcLight app](https://github.com/sul-dlss/arclight/wiki/Creating,-installing,-and-running-your-ArcLight-application).

## Running in Vagrant

**Note:** We've had issues with running the Vagrant on Mac OS X.
The VirtualBox version appears to be critical. The following versions are
believed to work:

* Mac OS X (Mojave): VirtualBox v5.2.22
* Mac OS X (High Sierra): VirtualBox 5.1.30

Clone the repo and start up the Vagrant box:

```
git clone git@github.com:umd-lib/arclight-prototype.git
cd arclight-prototype
vagrant up
```

Start Solr:

```
vagrant ssh
cd /vagrant
solr_wrapper --version 7.3.0
```

In a separate terminal, start the ArcLight Rails app:

```
vagrant ssh
cd /vagrant
rails s
```

## Running in Docker

Clone the repo

```
git clone git@github.com:umd-lib/arclight-prototype.git
cd arclight-prototype

```
Setup Solr
```
# Download the solr zip to `dist` directory with name `solr.zip`
curl -o dist/solr.zip http://lib-solr-mirror.princeton.edu/dist/lucene/solr/7.5.0/solr-7.5.0.zip

# Setup
bundle install
solr_wrapper -v --config .solr_wrapper.yml --solr_zip_path dist/solr.zip  --instance_directory solr/instance --persist
```

Build the Docker image:

```
docker build . -t arclight
```

Start a Docker container from this image:

```
docker run --rm -p 3000:3000 -p 8983:8983 --name arclight -it arclight
```

To connect to the running container and start a bash session:

```
docker exec -it arclight /bin/bash
```

It may also be helpful to connect via a Rails console:

```
docker exec -it arclight rails c
```

**Note:** There is currently no persistence of data from one container to another.
That is, every time you run `docker run` it will create a fresh, empty Solr core.

## Application URLs

For both the Vagrant and Docker methods of running this application, the
default URLs are:

* Solr: <http://localhost:8983>
* ArcLight App: <http://localhost:3000>

## Loading Sample Data

The following are derived from the <https://github.com/sul-dlss/arclight/wiki/Indexing-EAD-in-ArcLight>

### Vagrant

1) In the "arclight-prototype" directory on the host machine, create an "eads"
   directory:

```
mkdir eads
```

2) Copy any EAD files into the "eads" directory.

3) SSH into the Vagrant machine:

```
vagrant ssh
```

4) Switch the the "/vagrant" directory:

```
cd /vagrant
```

5) Run the following command to load the file:

```
FILE=./eads/<EAD_FILE_NAME> REPOSITORY_ID=<REPO_ID> bundle exec rake arclight:index
```

where <EAD_FILE_NAME> is the name of the file, and <REPO_ID> is the name of
the repositort from the "config/repositories.yml" file:

For example, to load the EAD file "0037.LIT_20181213_170001_UTC__ead.xml" into
the "umd" repository, command would be:

```
FILE=./eads/0037.LIT_20181213_170001_UTC__ead.xml REPOSITORY_ID=umd bundle exec rake arclight:index
```

### Docker

1) On the host, access the terminal in the Docker container:

```
docker exec -it arclight /bin/bash
```

2) Create an "eads" directory:

```
mkdir eads
```

3) In a separate terminal, copy EAD files into a running Docker container, use:

```
docker cp <EAD FILE> arclight:/home/arclight/eads
```

This will copy the file from the host to the ~/eads.

4) In the Docker container terminal, run the following command to load the file:

```
FILE=./eads/<EAD_FILE_NAME> REPOSITORY_ID=<REPO_ID> bundle exec rake arclight:index
```

where <EAD_FILE_NAME> is the name of the file, and <REPO_ID> is the name of
the repository from the "config/repositories.yml" file:

For example, to load the EAD file "0037.LIT_20181213_170001_UTC__ead.xml" into
the "umd" repository, command would be:

```
FILE=./eads/0037.LIT_20181213_170001_UTC__ead.xml REPOSITORY_ID=umd bundle exec rake arclight:index
```
