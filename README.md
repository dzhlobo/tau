Tau
===

Tau provides you write code of webpages using modern technologies such as 
haml, sass, coffee-script. You dont't need to compile your code to HTML and
CSS by hand everytime you something change.

Installation
------------

    gem install tau

Usage
-----

It's pretty simple.

### Getting started

1. Start new coding project and switch to that. In the command prompt run:

    `tau new example.com; cd example.com` *(where example.com is the project name)*

2. Create html or haml file on code directory:

    `echo "%h1 Hello <strong>tau</strong>!" > code/hello.haml`

3. Start server and go to [http://localhost:15000/hello.html](http://localhost:15000/hello.html):

    `tau server`

Attend even if you write hello.**haml** file you can see it by hello.**html**
in browser.

### Creating new project

Run `tau new projectname` and tau will make directory tree for you:
  
    projectname
    |--code - for your .html and .haml files
    |  |--js - for .js and .coffee files
    |  |--css - for .css, .sass and .scss
    |  `--img - for any type of images
    |
    `--tau.yaml - config file 

### Coding

Run `tau server` in your project directory. Then put any html or haml files
into **code** directory, js or coffee files into **code/js**, css, sass or
scss into **code/css**. Now you can view files in browser by 
http://localhost:15000/page.html or http://localhost:15000/css/style.css or 
http://localhost:15000/js/script.js.

Attend that tau changes files extensions in browser from haml to html, from 
coffee to js, from sass and scss to css. For example if you have 
**code/js/myscript.coffee** file you can see it in browser by 
http://localhost:15000/js/myscript.js.

In html or haml file you can include scripts written in coffee and styles 
written in sass or scss. For example if you have **code/js/script.coffee** 
script and **code/js/style.sass** spreadsheet you can include it to html by 
lines:
```html
    <script src='js/script.js'></script>
    <link rel="stylesheet" href="css/style.css">
```
Anytime you change any file you can see updated version in browser. You don't 
need to compile anything by hand.

License
-------

You can use tau by MIT License.

Contributing
------------

Feel free to fork and pull request.
