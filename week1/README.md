Introduction to Git 
==============
Myeong Lee
-------------

### <span style="color:grey">Table of Contents</span>
1. [What is Git?](#what)
2. [Why Git?](#why)
3. [Git Products](#products)
4. [Github Features](#features)
5. [Git Process](#process)
6. [Advanced Topics](#advanced)

<a name="what"></a>
# What is Git? 
- A version control system that allows to systematically manage code. 
- A comparable system is Subversion (a.k.a., [SVN](https://subversion.apache.org/)). 

<a name="why"></a>
# Why Git? 
- Git has become a standard tool for collaboration in software development and data analytics worlds. 
- Many developers and data scientists now contribute to open source software through Git (when an open source project is hosted on a Git-based website).
- Non-developers such as project managers also actively use Git to efficiently manage IT projects and collaborate with developers.

### Examples 
- Two developers are working on a software project. Developer A made changes in the code and published it to the server. The other developer B didn't know about this. He made his own changes and published it to the server. A's changes have gone since B didn't have A's changes on his laptop.
	- Git keeps track of every change from each person, so B cannot ignore A's changes if they're using Git for the project. 
- There is an open source project. Developer A is the organizer of the project. A made a main codebase and recruited other developers who wanted to contribute to the code. 1,000 people provided their own extensions to A, and A had a hard time reviewing all different kinds of codes. 
	- Git has a mechanism called "fork". This allows other developers freely modify a project. Once a contributor finishes his or her work, it is possible to make a "pull request" to the project organizer so that the organizer can manage various contributions in a systematic way.  
- Student A was working on a software project. She finished two out of three assignments. Then she modified something to finish the last part. Suddenly, the whole system didn't work and the first two parts were also broken due to the latest change. It was very hard to go back to the state before starting working on the third part.
	- Similar to the first example, Git keeps track of every code changes whenever a user "commits" his or her changes. It's very easy to go back to a previous state when something is broken.
	- See [an example](https://github.com/myeong/DCIC-Human-Face/commits/master) of a commit history on Github.

<a name="products"></a>	
# Git Products 
Git is an open source software, and many online services provide Git-based solutions **for free**! These are well-known products:

- [Github](http://github.com)
- [Bitbucket](https://bitbucket.org)
- [Assembla](https://www.assembla.com)

Also, it's possible to install your own Git system if you have a Linux server. A well-known product is [GitLab](https://gitlab.com). Installing your own Git system requires complex configurations and knowledge about Linux systems (so recommended only for advanced users, if needed). 

<a name="features"></a>
# GitHub Features
We will use [Github](http://github.com) in this session since it is most widely used one among Git services. Basic functionalities and concepts are similar to other Git services. Github provides several features along with the original Git functionality. Major ones are as follows:

1. Branching
	- For a Git repository, it's possible to make other branches so to keep the original codebase (useful when developing a particular feature while not wanting to break the original code).
2. Forking
	- If you're interested in an existing (public) project by other users, you can "fork" the project to your account. This copies the entire project to your own account so you can work freely on it. 
3. Basic Website
	- Github provides a functionality to create a simple website that directly uses the code on your Git repo.
	- The URL convention is `http://[title].github.io`
4. MarkDown (MD) Support
	- Markdown is a simple language for web-based documents.
	- You can write a Markdown document using MD syntax. Then, its rendered document appears on the Git repo page. 
5. Privacy Setting
	- It's possible to make your repo private (so other people cannot see your private repos). In Github, the private repo service is not free, but there's a student account option. 
6. Code Review Interface
	- When a pull request is made (i.e., someone wants to make a contribution to an existing project), the owner of the project can review others' code line-by-line and make comments on each line if necessary. 
	- Since only lines that are changed are shown to the owner, it's easy to review others' contributions. 
7. Issues
	- It's possible to discuss any issue related to a project like in online forums. This feature faciliates communications between project owners and other contributors and users.

<a name="process"></a>
# Git Process
This is the core part of the Git session: how to use the Git?

### Prerequisites
In order to use Git on your computer, you might need to install an app. After install the required app, every Git process is done either on the Github website or on your command-line app.

- If you're using **Mac**, it is possible that Git is already installed along with Xcode. Try to open the "Terminal" app, and type `git` and hit "enter". If not installed, Mac will automatically open a window to install Git. 
- If you're using **Windows**, install "Git Shell" or "Git Bash". It is available at [this link](https://git-scm.com/download/win)
- If you're using **Linux**, see [this page](https://git-scm.com/download/linux) for the instruction -- the installation command is different depending on the Linux version.

### Creating a Git Repo (on the Github Website)

1. Create your account and log in.
2. Click the "New repository" button.
3. Enter "Repository Name" and "Description" (e.g., "Myeong-Git-Test")
4. Set whether you want to make it "Public" or "Private". For this exercise, just make it "Public".
5. Click "Create Repository"

<a name="clone"></a>
### Cloning a Git Repo (Github &rarr; Your PC, only once)
Git clone is required only once for each repository (at the very first time). 

1. On your Git repo page, click "Clone or Download". 
2. Copy the address. If you have not set your SSH key (or if you don't know what SSH means), copy the address that starts with `https://`.
3. Open a terminal (on Macs, it is the "Terminal" app, and on Windows, it is the "Git Shell" app), and go to a folder where you want to locate your Git repo's files. In order to move to a designated folder, you need to use Linux commands. For example:

	```
	# list files in the current directory
	ls
	
	# getting into a directory
	cd [folder_name]
	
	# getting out of a directory
	cd ..
	```
4. In the designated folder (on the command line), type the following:

	```
	git clone [your Git repo URL that you copied]
	```
5. Then, it automatically downloads all files from your Git repo to your computer. It is possible that there's no file (if you haven't created anything). 
6. In order to check whether it downloaded successfully, get into the folder

	```
	# Getting into the directory
	cd [the downloaded Git repo name]
	
	# Check whether it was successful
	git status
	```
7. If the result of `git status` shows something like `Your branch is up-to-date`, then that means it was successful. If you cannot get into the folder, or you see any error messages, it was not successful somehow. 

### Making Changes in Your Repo
Mostly, you will work on your computer. In the cloned folder, you can create files that you will work on. Let's try to create a sample file for exercise. 

1. You can create a simple text file using your editor app, or in the command line. 
	- Open a text editor that you usually use (e.g., UltraEdit, Sublime Text, NotePad++, etc.). For Markdown files, you can also use a web-based editor such as [Markdown Editor](https://jbt.github.io/markdown-editor/), and copy the text after you write something down. 
	- Create a new file.
	- Write something in it.
	- Save it in the cloned folder as `[your_name].md`.
2. Once you create a new file, you just made a change on your local Git repository.
3. In the terminal, type:

	```
	git status
	```
	- The result will show that there's a new "untracked" file in the repo. However, this is only new in your local machine. We need to commit this to your Git repo online. 

### Adding and Commiting Your Changes (Your PC &rarr; Github, whenever you make changes)

1. First of all, you need to register your changes so your files are controled under the Git system. The first step is to "add" your changes.
Type:
	
	```
	# Dot (.) means everything in the folder.
	git add .
	```
2. Then, you need to tell the system that you want to save the current status. This is called "commit". Type: 

	```
	git commit -m "this is a test file by [your_name]"
	```
	The message inside the double quotes is your log message so that other people can understand what you did: You need to briefly explain what changes you made.	
3. Finally, upload your changes to your online repo (in the Github). Type:
 
	```
	git push origin master
	```
	By default, your branch is "master". Later, you can create other branches as needed.


### Branching 
If you want to keep your code safe, and do some experiment with it at the same time, you can use "branching". In your repo, you can create a new branch by typing:

``` 
git checkout -b [branch_name]
```
Note that the `-b` option is only needed when you first create a new branch. You will not use this option for existing branches. 
Then, you have created a new branch and now you're in the new branch. Your "master" branch is safely kept in another world. If you want to check what branch you're in, you can type:

```
git branch
```
Make changes in your original test file using your editor, and save it. If you type `git status`, you can see there is a change in your repo. Add, commit, and push to your Github repo. You need to be careful: now you're pushing to your new branch, not to your master branch. For example:

```
git add .
git commit -m "new branch's change"
git push origin [branch_name]
```

Let's suppose that your experiment in the new branch was successful. Then, you want to merge your changes in the new branch to your master branch. In this case, you need to switch to the master branch first by typing:

```
git checkout master
```
Now, you're in the master branch without your new changes. You can merge the new changes from the other branch by typing:

```
git merge [branch_name]
```
Now, your master branch has the new changes made in the new branch. However, these changes are only in your computer, not on the Github repository (you pushed your changes to your new branch only, not to the master branch yet).

Since the changes are already added and committed in the new branch, you can just push it in the master branch. 

```
git push origin master
```
Then, both of your branches have up-to-date changes. 

It is possible to see graphically how your branching has been processed on the website. Go to your project repo page, and click the "Graphs" menu. In there, click the "Network" button.
Then, it shows how branches were created and merged among each other. 


### Exercise: Forking and Contributing to the Original Code Base
1. Go to this Git repo web page: `https://github.com/myeong/INST377`
2. Click "Fork"
3. Go to your forked repo. It should be something like `https://github.com/[your_id]/INST377`
4. Clone it to your PC.
5. Go to `git/introductions/` folder, and create a Markdown file with your last name. `[your_last_name].md`
6. Open the file, write down any sentence into the Markdown file, and save it. 
7. In the command line, `git add .`
8. `git commit -m "my name added"`
9. `git push origin master`
10. On the Github repo page, click "pull request" button and submit your pull request.
11. The instructor comments on the pull requests and merges them.
12. Now, your change has been applied to the original project repository.
13. Check the registered Git addresses by typing `git remote -v`
14. You want to pull the most recent changes to your local computer. In order to do that, your PC needs to know the address of the original repo. 
Type `git remote add upstream https://github.com/myeong/INST377.git` 
15. Check again whether the original repo has been registered.
	- `git remote -v`
16. The original repo that you are contributing to is now registered on your local folder. 
17. Pull down the most recent changes on your computer by typing 
	- `git fetch upstream`
18. Merge "upstream" to your local repo.
	- `git merge upstream/master`
19. Push the most recent changes to your online repo
	- `git push origin master`


### Collaborating with your Colleague(s)
For your own project, you normally use `commit` and `push` to manage your code, and you may not use other commands that much. However, Git is often used for collaboration with other colleagues. Let's do some exercises on collaborating with your friend. 

1. Pair up with a colleague next to you. On the browser, go to your friend's Git repo page by typing your friend's Git repo URL. For example, you may go to `https://github.com/myeong/INST377`
2. Click the "Fork" button at the top. 
3. Once you fork your friend's repo, you just copied your friend's precious project to your account. 
4. Go to your forked repo page (you can see it in your repo list on your main Git page).
5. Go to the terminal, get out of your original repo folder. For example: 

	```
	cd ..
	```
6. Clone your forked repo to your computer. The steps are same as before, but just the address of the repo is different. If not sure, follow the steps in [Cloning a Git Repo](#clone).
7. Get into the cloned repo folder. Remember, this is a repo "forked" from your friend's account. 

	```
	cd [name of the forked repo]
	```
8. In the forked folder, there is a file that your friend created. Let's create another file. 	
	- Open your text editor, create a new file, write something in it, and save it into the forked repo folder with your name (e.g., `[your_name].md`).
	- Add, commit, and push your change. 
	- Once pushing your changes, your file is uploaded to your forked Git repo, not your friend's repo. But you want to give your changes to your friend.
9. Go to the web page of your forked repo. There is a button called "New Pull Request". Click it. 
10. You will see "base fork" and "head fork" in the web page. "Base fork" is the original repo that you want to contribute to (in this case, your friend's repo). "Head fork" is your forked repo that you just made changes to. You are basically trying to ask your friend to merge your changes.
11. If you see the "Create Pull Request" button (in green), click it. Then, you can write down a message about your contribution. Once you made a pull-request, your friend will receive the request from his or her email or on the Github website. **Now, as a contributor, your work is done.** 
12. As an original project owner, you receive a pull request from your friend. In your original project repo page, you can see there is one pull request. Click "Pull requests" menu. 
13. You can see your friend's message. If you have any opinion, you can comment on it as well. This conversation can go on as a thread. Once you're satisfied with your friend's contribution, click the `Merge Pull Request` button. Don't click `Comment and Close` button unless you don't want to merge it. Subsequenlty, it is possible that you need to click `Confirm merge` to complete the merge. 
14. Once it says it was successfully merged, your project is finally contributed by your friend. As a contributor, you also made success in contributing to your friend's project. 

### Pulling Your Repo (Github &rarr; Your PC, whenever there're any changes on Github)
Your Git repo has been contributed by your friend, but your computer still doesn't have your friend's contribution, because you accepted your friend's pull request online and never downloaded the new changes onto your computer. In this case, you need to "pull" the up-to-date changes. 

1. Go to your original repo folder on your computer (not the folked repo folder) using the `cd` command.
2. Type this:

	```
	git pull origin master
	```
3. Then, your friend's recent contribution will be downloaded to your computer. 


<a name="advanced"></a>
# Advanced Topics
We just covered very basic functionalities of Git. If your time allows, it's also very useful to know some more advanced features and topics that are available in Github. Advanced topics include, but are not limited to:

- [How to make a website using Github](https://pages.github.com/): when you want to provide a simple website about your project. 
- [How to use MarkDown](http://www.markdowntutorial.com/): when you create a simple but well-styled document for your Git repo page. 
- [How to resolve conflicts in the Git repo](https://help.github.com/articles/resolving-a-merge-conflict-on-github/): when conflicts occur while collaborating with your friends.
- [How to make a Git profile](https://help.github.com/articles/about-your-profile/): Your dedicated profile page about your technical work. One of strong portfolios on your resu&#769;me.
- [How to revert back to a previous state](https://github.com/blog/2019-how-to-undo-almost-anything-with-git): When you want to get back to a previous commit after making a mistake.

# Resources
- [Markdown Editor for Mac: MacDown](https://macdown.uranusjr.com/)
- [Markdown Editor for Windows: MarkdownPad](http://markdownpad.com/)
- [Git Tutorial Video](https://www.youtube.com/watch?v=HVsySz-h9r4)
- [Git Tutorial, Interactive Web](https://try.github.io) 
