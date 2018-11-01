# Rails TODO App
This is a simple porject for making TODO lists with tasks make in Ruby on Rails
# Getting started
To have run this project locally clone it into some folder on your computer
`git clone https://github.com/WR-96/mh-todo_app.git`

## Prerequisites
This project is were made with **ruby 2.5.1**, **rails 5.2.1** and **PostgreSQL 10.5** so you need to have those installed. You will also need to have installed **Node 8.10.0** and **npm 3.5.2**
## Install
Change your current directory to the folder project and run `bundle` to install all the gems and dependencies. Maybe you will have to run `bundle update` if the install fails.
Then create a Postgresql user for the project `createuser -dlP mh-todo_app` and give it a password, now `rails db:setup` and finally `rails s` to boot up the rails server.
### Mailer
In order to send mails you will need to do some extra configurations, first start sidekiq processing `bundle exec sidekiq -q default -q mailers`
Go to the file `app/config/application.yml` and put your gmail credentials of the account from which you want to send the mails.
```yaml
gmail_username: 'YOUR-USER@GMAIL.COM'
gmail_password: 'YOUR-PASSWORD'
```
Also you will need to permit the access to less secure apllictacions in your gmail account in order to send mails from this project, follow [this link](https://myaccount.google.com/lesssecureapps). After that a test email will be send on new users registration to the platform.
If you don't want to do it a preview of the email is avalible in `http://localhost:3000/rails/mailers/weekly_mailer/weekly_report`