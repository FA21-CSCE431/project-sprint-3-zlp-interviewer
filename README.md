# README

## Introduction ##

The zlp interviewer is an application that the Zachry Leadership Program can use as a way to schedule interviews. The admin can create a schedule which inlcudes day range, time range, length of interview, number of rooms, and breaks after certain number of interviews. Once the schedule is created, the candidates can use the application to pick time slots for interviews. Our application allows for only certain number of candiates, which is determined by the admin, per time slot. The admin can generate a csv file which has details of all the interviews scheduled and they will also recieve an email with interview details whenever a candidate signs up for a time slot.

## Requirements ##

This code has been run and tested on:

* Ruby - 3.0.2p107
* Rails - 6.1.4.1
* Ruby Gems - Listed in `Gemfile`
* PostgreSQL - 13.3 
* Nodejs - v16.9.1
* Yarn - 1.22.11


## External Deps  ##

* Docker - Download latest version at https://www.docker.com/products/docker-desktop
* Heroku CLI - Download latest version at https://devcenter.heroku.com/articles/heroku-cli
* Git - Downloat latest version at https://git-scm.com/book/en/v2/Getting-Started-Installing-Git

## Installation ##

Download this code repository by using git:

 `git clone https://github.com/your_github_here.git`


## Tests ##

An RSpec test suite is available and can be ran using:

  `rspec spec/`

## Execute Code ##

Run the following code in Powershell if using windows or the terminal using Linux/Mac

  `cd your_github_here`

  `docker run --rm -it --volume "$(pwd):/rails_app" -e DATABASE_USER=test_app -e DATABASE_PASSWORD=test_password -p 3000:3000 dmartinez05/ruby_rails_postgresql:latest`

  `cd rails_app`

Install the app

  `bundle install && rails webpacker:install && rails db:create && db:migrate`

Run the app
  `rails server --binding:0.0.0.0`

The application can be seen using a browser and navigating to http://localhost:3000/

## Environmental Variables/Files ##

Don't have any since didn't use Google OAuth

## Deployment ##
1. For this assignment you should work with your github repository environment_test that you created previously. It should contain the test_app that we built in lab 1 and 2.
2. (Start your docker and work in your terminal) Make sure you have dev, test and main branches. However, since we’re not really going to develop any new features, we won’t be using the dev branch in the assignment. We’ll be using test and main branches.
First, use $ git status  to see if your git is tracking the current dir.
If you haven’t created dev and test branches, please do it now. For example, commands to create a test branch with git:

![image](https://user-images.githubusercontent.com/71986659/135948039-22d70b59-03fa-4c4a-8662-b7c939c08520.png)

Note:
$ git checkout -b <branch> will create and switch to the new branch
$ git checkout <branch> will only switch to the branch
You don’t need to create a new branch in Github in advance, because $ git push origin <branch> will do it for you if Github doesn’t have a corresponding branch.

After you create all three branches, your Github should look like this: 
 
![image](https://user-images.githubusercontent.com/71986659/135948077-9673b8ee-26ce-401b-88e7-41b7effbabed.png)

3. Switch to the test branch. Command - $ git checkout test
4. We want to run the migration on each deploy automatically.
Create a file named Procfile in the root dir with this line of code
 
![image](https://user-images.githubusercontent.com/71986659/135948122-5a288ca7-b2d9-4bf3-994f-764ef745efa3.png)

5. Create a root route in config/routes.rb
 
![image](https://user-images.githubusercontent.com/71986659/135948148-f2db8c45-f85c-4aab-978f-4541420953bf.png)

6. Save the changes and push it to origin/test
$ git add .
$ git commit -m “add Procfile and route”
$ git push origin test

7. From the Heroku Dashboard
Click the New button in the top right of your app list and select Create new pipeline:
 
![image](https://user-images.githubusercontent.com/71986659/135948863-45ea06e3-0cd2-41db-9d39-d0462e25d2dd.png)

![image](https://user-images.githubusercontent.com/71986659/135948970-bc33efa7-9f34-424a-b06b-95d8cd003632.png)

Note: if there’s no app in a pipeline, the pipeline will disappear. Therefore we need to configure some apps as default.

8. Enable Review Apps. Do NOT select any options for this assignment. Click “Enable Review Apps” right away.

![image](https://user-images.githubusercontent.com/71986659/135948431-c45d21f6-5739-49d0-b7d2-34fb4f2e2b26.png)

9. Click “New app” in Review Apps. Choose the test branch. After you click “Create”, Heroku will start deploying immediately. Every time you make changes to the test branch, it triggers automatic deployment.

![image](https://user-images.githubusercontent.com/71986659/135948488-4def3e28-2aee-4743-91a1-7df18f1f5303.png)

10. We also need to create an app for staging.

![image](https://user-images.githubusercontent.com/71986659/135948509-85fbad41-a97d-4333-ac92-b2f2e7dbf431.png)

11. Click on the stage-test-app-1. Click Deploy. Choose the main branch for Automatic Deploys.

![image](https://user-images.githubusercontent.com/71986659/135948553-cca214a5-e921-4785-9b2b-2683b6f17ae2.png)

Great! You just created a pipeline ready for deployment!

12. Let’s make a small change to our app to see how Heroku pipeline works.
You should remain in the test branch ($ git checkout test). You can be creative and change/add something that won’t break your app. For example, I add something into app/views/books/index.html.erb.
Then save the changes and push to the remote test branch. Commands are the same as step 6.
You’ll see that Heroku starts automatic deployment in the review app. After the deployment is done, open the app and see if it works.

![image](https://user-images.githubusercontent.com/71986659/135948581-8ed1c1be-7964-41a9-9486-0bc54cc0e735.png)

13. Next, go to the Github website. Create a pull request and merge the changes from test to main
14. After the merge, you’ll see that Heroku is automatically deploying the staging app.

![image](https://user-images.githubusercontent.com/71986659/135948604-08bf5a98-5241-4d20-9c8d-470c5d5acddb.png)

15. When the staging app is ready, open the app and check if everything looks good. Then promote it to the production area.

![image](https://user-images.githubusercontent.com/71986659/135948649-39d786e5-ed24-47e3-9dd3-38d5fd6a49a2.png)

16. After your review app and production app are both deployed, take a screenshot of your pipeline interface. Include the screenshot and links to both apps in the submission report.

![image](https://user-images.githubusercontent.com/71986659/135948673-4f3fd547-1c55-4665-949b-1647f89399e7.png)

## CI/CD ##

We ran our code through Brakeman, Simple Cov, and Rubocop. Refer to GitHub Actions for more details.

## Support ##

Admins looking for support should first look at the application help page.
Users looking for help seek out assistance from the customer.
