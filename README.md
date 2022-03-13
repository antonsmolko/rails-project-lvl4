### Hexlet tests and linter status:
[![Actions Status](https://github.com/antonsmolko/rails-project-lvl4/workflows/hexlet-check/badge.svg)](https://github.com/antonsmolko/rails-project-lvl4/actions)
[![CI](https://github.com/antonsmolko/rails-project-lvl4/actions/workflows/ci.yml/badge.svg)](https://github.com/antonsmolko/rails-project-lvl4/actions/workflows/ci.yml)

## System requirements
* Ruby
* Node.js
* Yarn
* SQLite3
* [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli#download-and-install)

## Installation

```sh
make setup
make test # run tests
make lint # run linter
make check # run tests and linter
```

```shell
ngrok http 3000

ngrok by @inconshreveable                                                                                                                       (Ctrl+C to quit)
                                                                                                                                                                
Session Status                online                                                                                                                            
Account                       John Doe (Plan: Free)                                                                                                         
Version                       2.3.40                                                                                                                            
Region                        United States (us)                                                                                                                
Web Interface                 http://127.0.0.1:4040                                                                                                             
Forwarding                    http://1c9c-62-437-148-260.ngrok.io -> http://localhost:3000                                                                      
Forwarding                    https://1c9c-62-437-148-260.ngrok.io -> http://localhost:3000                                                                     
                                                                                                                                                                
Connections                   ttl     opn     rt1     rt5     p50     p90                                                                                       
                              1       0       0.00    0.00    20.35   20.35                                                                                     
                                                                                                                                                                
HTTP Requests                                                                                                                                                   
-------------                                                                                                                                                   
                                                                                                                                                                
POST /api/checks               200 OK 
```

```text
// .env
GITHUB_CLIENT_ID=<your client id>
GITHUB_CLIENT_SECRET=<your client secret>
BASE_URL=https://1c9c-62-437-148-260.ngrok.io
APP_HOST=https://1c9c-62-437-148-260.ngrok.io
MAIL_USERNAME=<your mail username>
MAIL_PASSWORD=<your mail password>
MAIL_HOST=<your mail host>
SMTP_PORT=<your mail port>
```

```shell
make start # run server http://localhost:3000
```

[Demo](https://hexlet-github-quality-lvl4.herokuapp.com/)