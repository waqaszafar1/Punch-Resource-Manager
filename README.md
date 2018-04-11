# Punch Resource Manager

This README would normally document whatever steps are necessary to get the
application up and running in local environment.

Things you may want to cover:

* Ruby version 2.3.1

* Rails version 5.1.5

* Sqlite (cause its dummy architecture )

## Setup

* clone repo

* run `bundle install`

* run `rake db:setup` | `rake db:create -> rake db:migrate -> rake db:seed`

## End Points

##### Get Authentication token through login

`POST http://localhost:3000/api/v1/login`

   ######form-data(key-value)
     
     `email:<look into seed.rb>`
     
     `password:<look into seed.rb>`
     
 

##### Employee 
######Get All Employees

* Get All the Employees(This call works without token too).
  
     `GET http://localhost:3000/api/v1/employees`
     
 
######Create an Employee

* Create an Employees(This call works only with token).Token will be send in header.

    `POST http://localhost:3000/api/v1/employees`
    
     ######form-data(key:value)
      
      `employee[name]:waqas`
      
      `employee[designation]:ROR Engineer`
    
 ######Get an Employee
 
 * Get an Employee(This call works without token too).
   
      `GET http://localhost:3000/api/v1/employees/:employee_id`
      

  
 ######Update an Employee
 
 * Update an employee(This call works only with token).Token will be send in header.
 
     `PUT http://localhost:3000/api/v1/employees/:employee_id`
     
      ######form-data(key:value)
       
       `employee[name]:waqas101`
       
       `employee[designation]:ROR Engineer` 
         
  ######Delete an Employee
  
  * Delete a selected id employee(This call works only with token).Token will be send in header.
    
       `Delete http://localhost:3000/api/v1/employees/:employee_id`
       
 ##### Project 
 ######Get All Projects
 
 * Get All the Projects(This call works without token too).
   
      `GET http://localhost:3000/api/v1/projects`
      
  
 ######Create a Project
 
 * Get All the Projects(This call works only with token).Token will be send in header.
 
     `POST http://localhost:3000/api/v1/projects`
     
      ######form-data(key:value)
       
       `project[title]:punch`
       
     
  ######Get a Project
  
  * Get a Project(This call works without token too).
    
       `GET http://localhost:3000/api/v1/projects/:project_id`
       
 
   
  ######Update a Project
  
  * Update a particular project(This call works only with token).Token will be send in header.
  
      `PUT http://localhost:3000/api/v1/project/:project_id`
      
       ######form-data(key:value)
        
        `project[title]:stats`
         
          
   ######Delete a Project
   
   * Delete a selected id project(This call works only with token).Token will be send in header.
     
        `DELETE http://localhost:3000/api/v1/project/:project_id`
         
   ######Add an employee to a Project
      
   * Add an employee to a specific project(This call works only with token).Token will be send in header.
        
           `POST http://localhost:3000/api/v1/projects/:project_id/add_employee`    
   
  ######form-data(key:value)
         
         `employee[id]:<any valid id>`
         
 ######Remove an employee to a Project
       
   * Remove an employee to a specific project(This call works only with token).Token will be send in header.
         
            `POST http://localhost:3000/api/v1/projects/:project_id/remove_employee`    
    
   ######form-data(key:value)
          
          `employee[id]:<any valid id>`
         

##### Client 
 ######Get All Client
 
 * Get All the Clients(This call works without token too).
   
      `GET http://localhost:3000/api/v1/clients`
      
  
 ######Create a Client
 
 * Get All the Client(This call works only with token).Token will be send in header.
 
     `POST http://localhost:3000/api/v1/Client`
     
      ######form-data(key:value)
       
       `client[name]:mathew`
       
     
  ######Get a Client
  
  * Get a Client(This call works without token too).
    
       `GET http://localhost:3000/api/v1/client/:client_id`
       
 
   
  ######Update a Client
  
  * Update a particular Client(This call works only with token).Token will be send in header.
  
      `PUT http://localhost:3000/api/v1/client/:client_id`
      
       ######form-data(key:value)
        
        `client[name]:mathew wang`
         
          
   ######Delete a Client
   
   * Delete a selected id client(This call works only with token).Token will be send in header.
     
        `DELETE http://localhost:3000/api/v1/client/:client_id`
         
   ######Add a Project to a Client
      
   * Add an project to a specific client(This call works only with token).Token will be send in header.
        
           `POST http://localhost:3000/api/v1/clients/:client_id/add_project`    
   
  ######form-data(key:value)
         
         `project[id]:<any valid id>`
         
 ######Remove an employee to a Project
       
   * Add an project to a specific client(This call works only with token).Token will be send in header.
         
            `POST http://localhost:3000/api/v1/client/:client_id/remove_project`    
    
   ######form-data(key:value)
          
          `employee[id]:<any valid id>`

 
## Automated Tests 

* Below are the commands to run automated tests written for end points and models.

  `bundle exec rspec` 

 
   #####NOTE: Test Specs are written in spec folder.Specs are their for models and endpoint requests.However, we only have endpoints specs for employee resource. 
