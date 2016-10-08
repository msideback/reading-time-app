# reading-time-app
The reading-time-app is a demo web application using Java and [Maven](https://maven.apache.org/). It lists staff recommended books.
## Installing And Running On a Local Machine
To install and run the `reading-time-demo` application on your local machine execute the following commands:
```
mvn clean install
sh target/bin/webapp
open http://localhost:8080
```
To skip the tests:
```
mvn -B -DskipTests=true clean install
```
To run the unit tests execute the following command:
```
mvn clean test
```
To run code coverage checks execute the following command:
```
mvn cobertura:check
```
To create the code coverage report execute the following command:
```
mvn cobertura:cobertura
open target/site/cobertura/index.html
```
To create and view the `reading-time-demo` reports:
```
mvn site
open target/site/index.html
```

## Travis CI Configuration
The minimal Travis CI configuration for Java is a `.travis.yml` file with the following content:
```
language: java
```
It will execute a standard maven install and test:
```
mvn install -DskipTests=true -Dmaven.javadoc.skip=true -B -V
mvn test -B
```
