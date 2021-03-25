# lendo-cicd

This is the cicd of the lendo interview application.

The lendo interview application is comprised of 4 repositories:
1. https://github.com/aeolus3000/lendo-cicd
2. https://github.com/aeolus3000/lendo-polling-service
3. https://github.com/aeolus3000/lendo-service/
4. https://github.com/aeolus3000/lendo-sdk/

# Architecture

The following diagram shows the architecture/setup of the application that is being 
launched by the cicd script.

![Architecture](/doc/architecture.png)


## Lendo Service

The lendo service exposes a REST-API on port 3000, shown by the arrow on the left of the service. 
With this REST-API it is possible to create and query loan applications.
Further documentation about the REST-API can be queried from http://localhost:3000/doc

When the lendo service receives a create application request, it performs the following steps:

1. Validate the request
2. Forward the request to the banking service
3. Push the response from the banking service in the channel "to polling"
4. Respond with the application

If an error is encountered in any of the steps, the response contains the error message.

When the lendo service receives a get application request, it performs the following steps:

1. Validate the request
2. Query the application from the database
3. Respond with the application

If an error is encountered in any of the steps, the response contains the error message.

When the lendo service receives a get applications request, it performs the following steps:

1. Validate the request
2. Extract filter parameters from the url
3. Query and filter applications from the database
4. Respond with the applications

If an error is encountered in any of the steps, the response contains the error message.

## Polling Service

The polling service receives loan applications from the lendo service through the to polling queue.
For each application it receives it polls the banking service and checks whether the status of the 
application has changed. If so, the application with updated status is pushed in the from polling queue.

# Using the application

Prerequisites: git, docker, docker-compose and make system installed

Please follow the following steps if you want to launch the application:

If you want to try without documentation, go ahead. These are the simple steps:
1. git clone https://github.com/aeolus3000/lendo-cicd.git
2. cd lendo-cicd
3. make start
4. wait a minute until all services are up n running
5. open http://localhost:3000
6. play around with the UI
7. study the rest API on http://localhost:3000/doc
8. use some tool like postman to send rest calls against the lendo service