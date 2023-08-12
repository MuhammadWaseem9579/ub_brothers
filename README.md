# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
- ruby "3.2.0"

* System dependencies
  - sudo apt install mysql-server
    - run this command if got error while installing mysql2
      - sudo apt-get install libmysqlclient-dev

* Configuration
  - run following commands to setup database
    - sudo systemctl start mysql.service
    - sudo mysql
    - ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
    - exit

* Database creation
  - rake db:create

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
