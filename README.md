# Buy 'N Large

[![Build Status](https://travis-ci.com/jason-meredith/shopify-summer2019.svg?branch=master)](https://travis-ci.com/jason-meredith/shopify-summer2019)
[![Maintainability](https://api.codeclimate.com/v1/badges/2f95f3276758914ba7f9/maintainability)](https://codeclimate.com/github/jason-meredith/shopify-summer2019/maintainability)

My name is Jason Meredith and this is my submission for the **Shopify Summer 2019 Developer Internship challenge**.

Buy 'N Large is a simple shopping backend JSON API powered by Ruby on Rails. The front-end features a very basic 
Postman-style interface with a guide to all available API endpoints and the data they accept. It can be used to manage
and manipulate both a simple catalogue of Products as well as Users with a simple shopping cart mechanism. Actions performed
upon these resources are carried out through RESTful API calls, generally through a web browser or tools like `cURL` or 
Postman, or in this case through the simple front-end interface I designed for this project.

## Table of Contents

1. [How To Use](#how-to-use)
2. [Deployment](#deployment)
3. [Technologies Used](#technologies-used)
4. [Endpoints](#endpoints)


## How To Use

Buy 'N Large is very simple to use. Clicking on the 'Show API endpoints' button below page's address bar will open a 
dropdown box showing all actions available and the URL route used to call these actions, as well as the data that can be
attached to the body of the request. Request body data is added using the other button below the page's address bar, 
'Add HTTP Body Data'. Key value pairs can be added in the textboxes that appear below. Click the + to add additional values.

Once a URL in inputted in the address bar and body data has been added, use the dropdown on the right to generate the 
using the selected HTTP action method. Once the request is sent (via XHR) to the server a response is generated by the 
server and sent back and displayed in the body window at the bottom of the page.

## Deployment

As with any simple Rails app Buy 'N Large is very easy to deploy.

Clone the repository from Github
```
$ git clone https://github.com/jason-meredith/shopify-summer2019.git
$ cd shopify-summer2019
```

Configure your database settings in `config/database.yml`

Install dependencies and run the tests
```
$ bundle install
$ rake db:schema:load
$ rake test
```

Run server
```
$ rails server
```


## Technologies Used

**Web Framework**

I used Ruby on Rails as the framework for this project. I know Shopify one of, if not the the biggest Ruby on Rails 
applications active on the internet today and an active contributor the development of Ruby on Rails. For this reason
I thought it most appropriate to use it for this challenge. I have also been learning Rails in my spare time
 for some time now (see [Timeslots](https://github.com/jason-meredith/timeslots)) and while I try to dip my toes
in everything out there right now (Node.js, Django, Spring) Rails seems to be the one that held my attention.

**DevOps Toolchain**

In terms of deployment my web application - as progress is made - is pushed through a pipeline of sorts. Firstly
I am using Github for Version Control and hosting the source code (obviously). Using Githubs webhooks whenever a
push is made a build is triggered on my Travis CI page. Travis runs the tests, makes sure everything builds properly
and if it builds it triggers another push to Heroku where my app is deployed in it's production environment.

**Frontend**

I am by no means a front-end web designer, but that doesn't mean I can't put together a pleasant looking webpage.
For the front end of the web application I have a single view, `welcome#index` which has the API endpoint guide and 
a simple tool for building web requests and displaying the response from the server. For this I used jQuery for
building the AJAX calls, Bootstrap to make all the input forms looks pretty and SASS for custom CSS rules.

## Endpoints

All API endpoints can be called from the index page and displayed in it's output text area. All information is returned
in JSON format. As well as being explained belong all endpoints are outlined in the index page of application itself.

### Products

| Method | URI               | Description                             | Data            |         |                              |
|--------|-------------------|-----------------------------------------|-----------------|---------|------------------------------|
| GET    | /api/products     | Show all products                       | in_stock        | boolean | Only show products in stock? |
| GET    | /api/products/:id | Show details for product with given :id |                 |         |                              |
| POST   | /api/products     | Create new product                      | title           | string  | Product name                 |
|        |                   |                                         | price           | float   | Cost of product              |
|        |                   |                                         | inventory_count | integer | How many are in stock        |
| PUT    | /api/products     | Edit product details                    | id              | integer | ID of product to be edited   |
|        |                   |                                         | title           | string  | Product name                 |
|        |                   |                                         | price           | float   | Cost of product              |
|        |                   |                                         | inventory_count | integer | How many are in stock        |
| DELETE | /api/products/:id | Delete product with given :id           |                 |         |                              |


### Users

| Method | URI                           | Description                                                   | Data       |         |                              |
|--------|-------------------------------|---------------------------------------------------------------|------------|---------|------------------------------|
| GET    | /api/users/:id                | Show details for a user with a given :id                      |            |         |                              |
| GET    | /api/users                    | Get a list of all users                                       |            |         |                              |
| POST   | /api/users                    | Create a new user                                             | first_name | string  | User first name              |
|        |                               |                                                               | last_name  | string  | User last name               |
|        |                               |                                                               | email      | string  | User email address           |
| POST   | /api/users/:id/addToCart      | Add a product to a cart belonging to a user with a given :id  | product_id | integer | ID of product to add to cart |
|        |                               |                                                               | amount     | integer | Amount of product to add     |
| GET    | /api/users/:id/showCart       | Show the cart belonging to a user with a given :id            |            |         |                              |
| GET    | /api/users/:id/showCartTotal  | Show the cart total belonging to a user with a given :id      |            |         |                              |
| DELETE | /api/users/removeFromCart/:id | Delete a cart item with a given :id                           |            |         |                              |
| POST   | /api/users/:id/checkout       | Checkout a user (purchase all items in cart) with a given :id |            |         |                              |
