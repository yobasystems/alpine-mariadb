# MariaDB Docker image running on Alpine Linux

[![Docker Automated build](https://img.shields.io/docker/automated/yobasystems/alpine-mariadb.svg?style=for-the-badge&logo=docker)](https://hub.docker.com/r/yobasystems/alpine-mariadb/)
[![Docker Pulls](https://img.shields.io/docker/pulls/yobasystems/alpine-mariadb.svg?style=for-the-badge&logo=docker)](https://hub.docker.com/r/yobasystems/alpine-mariadb/)
[![Docker Stars](https://img.shields.io/docker/stars/yobasystems/alpine-mariadb.svg?style=for-the-badge&logo=docker)](https://hub.docker.com/r/yobasystems/alpine-mariadb/)

[![Alpine Version](https://img.shields.io/badge/Alpine%20version-v3.12.0-green.svg?style=for-the-badge&logo=alpine-linux)](https://alpinelinux.org/)
[![MariaDB Version](https://img.shields.io/badge/Mariadb%20version-v10.4.15-green.svg?style=for-the-badge&logo=mariadb)](https://mariadb.org/)


This Docker image [(yobasystems/alpine-mariadb)](https://hub.docker.com/r/yobasystems/alpine-mariadb/) is based on the minimal [Alpine Linux](https://alpinelinux.org/) with [MariaDB v10.4.15](https://mariadb.org/) (MySQL Compatible) database server.

##### Alpine Version 3.12.0 (Released May 29, 2020)
##### MariaDB Version 10.4.15

----

## What is Alpine Linux?
Alpine Linux is a Linux distribution built around musl libc and BusyBox. The image is only 5 MB in size and has access to a package repository that is much more complete than other BusyBox based images. This makes Alpine Linux a great image base for utilities and even production applications. Read more about Alpine Linux here and you can see how their mantra fits in right at home with Docker images.

## What is MariaDB?
MariaDB Server is one of the most popular database servers in the world. It’s made by the original developers of MySQL and guaranteed to stay open source. Notable users include Wikipedia, WordPress.com and Google.

MariaDB turns data into structured information in a wide array of applications, ranging from banking to websites. It is an enhanced, drop-in replacement for MySQL. MariaDB is used because it is fast, scalable and robust, with a rich ecosystem of storage engines, plugins and many other tools make it very versatile for a wide variety of use cases.

MariaDB is developed as open source software and as a relational database it provides an SQL interface for accessing data. The latest versions of MariaDB also include GIS and JSON features.

## Features

* Minimal size only, minimal layers
* Memory usage is minimal on a simple install.
* MariaDB the MySQL replacement


## Architectures

* ```:amd64```, ```:x86_64``` - 64 bit Intel/AMD (x86_64/amd64)
* ```:arm64v8```, ```:aarch64``` - 64 bit ARM (ARMv8/aarch64)
* ```:arm32v7```, ```:armhf``` - 32 bit ARM (ARMv7/armhf)

##### PLEASE CHECK TAGS BELOW FOR SUPPORTED ARCHITECTURES, THE ABOVE IS A LIST OF EXPLANATION

## Tags

* ```:latest``` latest branch based (Automatic Architecture Selection)
* ```:master``` master branch usually inline with latest
* ```:amd64```, ```:x86_64```  amd64 based on latest tag but amd64 architecture
* ```:aarch64```, ```:arm64v8``` Armv8 based on latest tag but arm64 architecture
* ```:armhf```, ```:arm32v7``` Armv7 based on latest tag but arm32 architecture

## Layers & Sizes

![Version](https://img.shields.io/badge/version-amd64-blue.svg?style=for-the-badge)
![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/yobasystems/alpine-mariadb/amd64.svg?style=for-the-badge)
![MicroBadger Size (tag)](https://img.shields.io/microbadger/image-size/yobasystems/alpine-mariadb/amd64.svg?style=for-the-badge)

![Version](https://img.shields.io/badge/version-aarch64-blue.svg?style=for-the-badge)
![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/yobasystems/alpine-mariadb/aarch64.svg?style=for-the-badge)
![MicroBadger Size (tag)](https://img.shields.io/microbadger/image-size/yobasystems/alpine-mariadb/aarch64.svg?style=for-the-badge)

![Version](https://img.shields.io/badge/version-armhf-blue.svg?style=for-the-badge)
![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/yobasystems/alpine-mariadb/armhf.svg?style=for-the-badge)
![MicroBadger Size (tag)](https://img.shields.io/microbadger/image-size/yobasystems/alpine-mariadb/armhf.svg?style=for-the-badge)


## Volume structure

* `/var/lib/mysql`: Database files
* `/var/lib/mysql/mysql-bin`: MariaDB logs


## Environment Variables:

### Main Mariadb parameters:
* `MYSQL_DATABASE`: specify the name of the database
* `MYSQL_USER`: specify the User for the database
* `MYSQL_PASSWORD`: specify the User password for the database
* `MYSQL_ROOT_PASSWORD`: specify the root password for Mariadb
* `MYSQL_CHARSET`: default charset (utf8) for Mariadb
* `MYSQL_COLLATION`: default collation (utf8_general_ci) for Mariadb


#### List of Character Sets & information

When setting charset, also make sure to choose a collation otherwise it will be the default.

```
+----------+-----------------------------+---------------------+--------+
| Charset  | Description                 | Default collation   | Maxlen |
+----------+-----------------------------+---------------------+--------+
| big5     | Big5 Traditional Chinese    | big5_chinese_ci     |      2 |
| dec8     | DEC West European           | dec8_swedish_ci     |      1 |
| cp850    | DOS West European           | cp850_general_ci    |      1 |
| hp8      | HP West European            | hp8_english_ci      |      1 |
| koi8r    | KOI8-R Relcom Russian       | koi8r_general_ci    |      1 |
| latin1   | cp1252 West European        | latin1_swedish_ci   |      1 |
| latin2   | ISO 8859-2 Central European | latin2_general_ci   |      1 |
| swe7     | 7bit Swedish                | swe7_swedish_ci     |      1 |
| ascii    | US ASCII                    | ascii_general_ci    |      1 |
| ujis     | EUC-JP Japanese             | ujis_japanese_ci    |      3 |
| sjis     | Shift-JIS Japanese          | sjis_japanese_ci    |      2 |
| hebrew   | ISO 8859-8 Hebrew           | hebrew_general_ci   |      1 |
| tis620   | TIS620 Thai                 | tis620_thai_ci      |      1 |
| euckr    | EUC-KR Korean               | euckr_korean_ci     |      2 |
| koi8u    | KOI8-U Ukrainian            | koi8u_general_ci    |      1 |
| gb2312   | GB2312 Simplified Chinese   | gb2312_chinese_ci   |      2 |
| greek    | ISO 8859-7 Greek            | greek_general_ci    |      1 |
| cp1250   | Windows Central European    | cp1250_general_ci   |      1 |
| gbk      | GBK Simplified Chinese      | gbk_chinese_ci      |      2 |
| latin5   | ISO 8859-9 Turkish          | latin5_turkish_ci   |      1 |
| armscii8 | ARMSCII-8 Armenian          | armscii8_general_ci |      1 |
| utf8     | UTF-8 Unicode               | utf8_general_ci     |      3 |
| ucs2     | UCS-2 Unicode               | ucs2_general_ci     |      2 |
| cp866    | DOS Russian                 | cp866_general_ci    |      1 |
| keybcs2  | DOS Kamenicky Czech-Slovak  | keybcs2_general_ci  |      1 |
| macce    | Mac Central European        | macce_general_ci    |      1 |
| macroman | Mac West European           | macroman_general_ci |      1 |
| cp852    | DOS Central European        | cp852_general_ci    |      1 |
| latin7   | ISO 8859-13 Baltic          | latin7_general_ci   |      1 |
| utf8mb4  | UTF-8 Unicode               | utf8mb4_general_ci  |      4 |
| cp1251   | Windows Cyrillic            | cp1251_general_ci   |      1 |
| utf16    | UTF-16 Unicode              | utf16_general_ci    |      4 |
| utf16le  | UTF-16LE Unicode            | utf16le_general_ci  |      4 |
| cp1256   | Windows Arabic              | cp1256_general_ci   |      1 |
| cp1257   | Windows Baltic              | cp1257_general_ci   |      1 |
| utf32    | UTF-32 Unicode              | utf32_general_ci    |      4 |
| binary   | Binary pseudo charset       | binary              |      1 |
| geostd8  | GEOSTD8 Georgian            | geostd8_general_ci  |      1 |
| cp932    | SJIS for Windows Japanese   | cp932_japanese_ci   |      2 |
| eucjpms  | UJIS for Windows Japanese   | eucjpms_japanese_ci |      3 |
+----------+-----------------------------+---------------------+--------+
```

> https://mariadb.org/

## Creating an instance


```bash
docker run -it --name mysql -p 3306:3306 -v /var/lib/mysql:/var/lib/mysql -e MYSQL_DATABASE=wordpressdb -e MYSQL_USER=wordpressuser -e MYSQL_PASSWORD=hguyFt6S95dgfR4ryb -e MYSQL_ROOT_PASSWORD=hguyFtgfR4r9R4r76 yobasystems/alpine-mariadb

```

It will create a new db, and set mysql root password (default is RaNd0MpA$$W0Rd generated by pwgen) unless the data already exists.

### Configuration without a cnf file
Many configuration options can be passed as flags to mysqld. This will give you the flexibility to customise the container without needing a .cnf file. For example, if you want to change the default encoding and collation for all tables to use UTF-8 (utf8mb4) just run the following:

```bash
docker run --name some-mariadb -e MYSQL_ROOT_PASSWORD=my-secret-pw -d yobasystems/alpine-mariadb --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci
```

command:
  - --character-set-server=utf8
  - --collation-server=utf8_bin
  - --explicit-defaults-for-timestamp=1

### Configuration file location
The configuration file is located;

  - /etc/my.cnf
  - /etc/my.cnf.d/mariadb-server.cnf

### Initialising a fresh instance
When a container is started for the first time, a new database with the specified name will be created and initialised with the provided configuration variables. Furthermore, it will execute files with extensions .sh, .sql and .sql.gz that are found in /docker-entrypoint-initdb.d. Files will be executed in alphabetical order. You can easily populate your mariadb services by mounting a SQL dump into that directory and provide custom images with contributed data. SQL files will be imported by default to the database specified by the MYSQL_DATABASE variable.


## Docker Compose example:

##### (Please pass your own credentials or let them be generated automatically, don't use these ones for production!!)

```yalm
mysql:
  image: yobasystems/alpine-mariadb
  environment:
    MYSQL_ROOT_PASSWORD: hguyFtgfR4r9R4r76
    MYSQL_DATABASE: wordpressdb
    MYSQL_USER: wordpressuser
    MYSQL_PASSWORD: hguyFt6S95dgfR4ryb
  expose:
    - "3306"
  volumes:
    - /data/example/mysql:/var/lib/mysql
  restart: always
```

## Source Repositories

* [Github - yobasystems/alpine-mariadb](https://github.com/yobasystems/alpine-mariadb)

* [Gitlab - yobasystems/alpine-mariadb](https://gitlab.com/yobasystems/alpine-mariadb)

* [Bitbucket - yobasystems/alpine-mariadb](https://bitbucket.org/yobasystems/alpine-mariadb/)


## Container Registries

* [Dockerhub - yobasystems/alpine-mariadb](https://hub.docker.com/r/yobasystems/alpine-mariadb/)

* [Quay.io - yobasystems/alpine-mariadb](https://quay.io/repository/yobasystems/alpine-mariadb)


## Links

* [Yoba Systems](https://www.yobasystems.co.uk/)

* [Github - Yoba Systems](https://github.com/yobasystems/)

* [Dockerhub - Yoba Systems](https://hub.docker.com/u/yobasystems/)

* [Quay.io - Yoba Systems](https://quay.io/organization/yobasystems)

* [Maintainer - Dominic Taylor](https://github.com/dominictayloruk)

## Donation

[![BMAC](https://img.shields.io/badge/BUY%20ME%20A%20COFFEE-£5-blue.svg?style=for-the-badge&logo=buy-me-a-coffee)](https://www.buymeacoffee.com/dominictayloruk?new=1)

[![BITCOIN](https://img.shields.io/badge/BTC-bc1ql0heex0jxh0yj5cucc83a3x6c6rxuq6x9zk07g-blue.svg?style=for-the-badge&logo=bitcoin)](bitcoin:bc1ql0heex0jxh0yj5cucc83a3x6c6rxuq6x9zk07g)

[![ETHEREUM](https://img.shields.io/badge/ETH-0x6b707391c60d50E4E414a143446C0b8eF9A2d1c4-blue.svg?style=for-the-badge&logo=ethereum)](https://etherscan.io/address/dominictaylor.eth)

[![STELLAR](https://img.shields.io/badge/XLM-GAREZZW36KF2IT2EJW6LG5HH4XT3QIMWCHMCGEBC6V3AP3EFJCORRZIY-blue.svg?style=for-the-badge&logo=stellar)](https://keybase.io/dominictayloruk)
