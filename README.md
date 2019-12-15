# Ticket
Basic ticket system developed in spring boot which includes the following modules: Ticket Module, Employee Module and Report Module

## Getting Started

These instructions will get you a copy of the project up and running on your local machine. See Prerequisite for notes on how to install and run the application.

### Prerequisites
Before starting with the installation it's important to install docker because the web application for tickets is distributed this way
because it's a tool designed to make it easy to deploy and run applications by using containers. 

Below you can find the different links to install docker for the operating system you're using:
* [Windows](https://www.youtube.com/watch?v=GIMExUnjzMw) - Video docker installation for Windows
* [Mac](https://www.youtube.com/watch?v=O4Yro0VN5Ds&t=23s) - docker installation for Mac
* [Linux](https://www.youtube.com/watch?v=W7BvS942UZA) - Video docker installation for Linux

Also docker desktop is the easiest way to install docker if you're using Mac os or Windows. Visit the link bellow to install docker. 
[Docker installation resource for Window and Mac](https://www.docker.com/products/docker-desktop) - Docker desktop

Other docker installation resources
* [Docker Engine - Community for Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/) 
* [Docker Desktop on Mac](https://docs.docker.com/docker-for-mac/install/)

### Installing

After Docker is installed, download the following docker file [docker-compose.yml](https://github.com/maximor/ticket/blob/master/docker-compose.yml).


Now is time to run our application in docker. 

In the command line go where the docker-compose.yml file was downloaded and type the following command: 
```
docker-compose -f docker-compose.yml up
```

This command will download all resources and run the application automatically.

Now, open your favorite browser like Chrome, FireFox and just write localhost and your will be able to use the ticket web application, Example:

![](application-images/browser.png)

## Application Credentials

When the application runs for the first time, it creates a user administrator:

Email: admin@administrator.com

Password: admin

## Visual Summary

* [Application Images](https://github.com/maximor/ticket/tree/master/application-images) - Images with the main modules of the application.

## Built With
* [Java 8](https://www.oracle.com/java/technologies/java-ee-sdk-download.html) - The programming language
* [Spring Boot 2.2.3](https://spring.io/projects/spring-boot) - The web framework used
* [Freemarker](https://freemarker.apache.org/) - Template Engine
* [Maven](https://maven.apache.org/) - Dependency Management
* [H2](https://www.h2database.com/html/main.html) - Embedded Database
* [Gradient able](http://lite.codedthemes.com/gradient-able/bootstrap/index.html) - Template

## Authors

* **Maximo Rodriguez** - *Creator* - [Maximor](https://github.com/maximor)

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/maximor/ticket/blob/master/LICENSE) file for details

