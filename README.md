# OVERVIEW

This is a very small project to try to get a Django app connecting to a MySQL
database on my local computer.

It must be able to connect when run on the local computer and it also needs to
be able to connect when using a Dockerfile.

Currently I can get it to connect when run on my local computer (mac), but I
cannot get the Dockerfile connection to work.   I would very much appreciate
some help.

The details of my system are specified below.

### MySQL Setup

---

To setup a database on a MySQL server, you could use the following commands:

```SQL
CREATE DATABASE dbMarksMySQL;
```
To create a new user use one of the following and make appropriate adjustments:
```SQL
CREATE USER 'junk_admin'@'%' IDENTIFIED BY 'password';
```
Other commands that may be useful:
```SQL
USE dbMarksMySQL
GRANT ALL PRIVILEGES ON dbMarksMySQL.* TO 'junk_admin'@'%';
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'junk_admin'@'%';
```

Please note that a test database or permissions have not been added here.

### REQUIREMENTS FILE

---

* In the requirements.txt file I have removed the number for the mysqlclient, ie:
    ```
    ...
    Django==3.2
    mysqlclient
    pytz==2021.1
    ...
    ```

### MAKE FILE

---

I have created a makefile to help clean things up, create a virtual environment and run the project.   There are 3 main commands for running the project:

* make clean                  - Used to clean the environment up.
* make venv                   - Used to create the virtual environment from requirements.txt
* make run-local-debug        - This runs the Django project on my localhost in debug mode.
* make run-local              - This runs the Django project on my localhost.
* make run-dock               - This builds and runs the Django project within a container defined by the local Dockerfile.

The majority of the commands work except for 'run-dock'.   I cannot get it to work with the Dockerfile.

### SYSTEM AND TYPICAL ERRORS

---

I am running this code on a Macbook Pro with macOS Catalina Version 10.15.7 and there is
a MySQL 5.7.29 database installed.

This shows the typical error that I get when running the Dockerfile version of this project:

![Typical Error](./img/TypicalError.png)