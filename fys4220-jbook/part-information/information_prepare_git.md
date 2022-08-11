(information-preparing-git)=
# Git  

This section will give you a brief introduction to Git and how we will use Github.uio.no in this course.

```{admonition} Note!
:class:
Notice that we are using a UiO managed version of Github – Github.uio.no – and **NOT** Github.com.
```

There is no need to become and expert Git user.  The most common commands you will use are:
* *git clone* 
* *git add* 
* *git commit*
* *git tag*
* *git pull*
* *git push*
* *git status*

A list of basic Git commands can be found here: Basic Git commands from https://confluence.atlassian.com/bitbucketserver/basic-git-commands-776639767.html


There are many good resources on Git online and we encourage you to have a look at them. Some examples are:
* Informasjon on Github at UiO (Norwegian only): http://www.uio.no/tjenester/it/maskin/filer/versjonskontroll/github.html 
* Git tutorials from Atlassian: https://www.atlassian.com/git/tutorials/
* Pro Git: https://git-scm.com/book/en/v2
* Git Reference : http://git.github.io/git-reference/
* Become a Git pro in just one blog. A thorough guide to Git architecture and command line interface: https://itnext.io/become-a-git-pro-in-just-one-blog-a-thorough-guide-to-git-architecture-and-command-line-interface-93fbe9bdb395 (Tip: open page in your browser's private mode if you have exceeded the medium.com's free readings.)



It can also be worth watching the introduction lecture (about 53 min)  on Git from one of the popular CS50 courses at Harvard:

<div class="video-container">
<iframe width="912" height="513" src="https://www.youtube.com/embed/NcoBAfJ6l2Q" title="CS50W - Lecture 1 - Git" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

<!--
*An introduction to Git by "Higher level programming" (around 20 minutes):*

<div class="video-container">
<iframe width="912" height="513" src="https://www.youtube.com/embed/vWdmXunGQC8" title="Introduction to Git" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

---
-->





<!--
---

*A lecture (about 1.5 hours) on Git from the "Missing semester" class at MIT: https://missing.csail.mit.edu*

<div class="video-container">
<iframe width="912" height="513" src="https://www.youtube.com/embed/2sjqTHE0zok" title="Lecture 6: Version Control (git) (2020)" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
-->

## Git on windows
On the windows computers in the FYS4220 lab. (V329) we have installed Git for Windows: https://git-for-windows.github.io. 

Git for Windows provides a BASH emulation *Git BASH* used to run Git from the command line. 

It also provides a graphical user interface *Git GUI*. However, we recommend to use the command line interface to get familiar with the basic Git commands.

There should be a link to *Git BASH* on the desktop. Double click on *Git BASH*, navigate to an appropriate directory and clone your Github.uio.no repository. The default path when starting *Git BASH* is typically your UiO home directory.

## Setup up a Github.uio.no repository
Before you start to work on the assignments and project, you will have to create a git repository on Github.uio.no. A Github *Organization* site called *FYS4220-2021* has already been created for FYS4220. If this organization is not visible after you have logged in to Github.uio.no, contact the course instructor.

The direct link to the organization is https://github.uio.no/FY4220-2021.


* Login in to Github.uio.no and create a new repository in the *FYS4220-2021* organization. Name the repository as shown in {numref}`assignments_gitrep_name` replacing *lastname* and *firstname* with your respective lastname and firstname.
```{figure} ../images/assignments_create_gitrep_name.png
---
width: 60%
align: center
name: assignments_gitrep_name
---
Name your Git repository accordingly. The image is from 2020. The organization for 2021 is named FYS4220-2021.
```
* Enable the *"Initialize this repository with a README"* and leave *.gitignore* initialization as *None* for the moment as shown in {numref}`assignments_gitrep_initialize`. Github does not provide a template *.gitignore*-file for VHDL. We will therefore add this file manually later.



```{figure} ../images/assignments_create_gitrep_initialize.png
---
width: 80%
align: center
name: assignments_gitrep_initialize
---
Initialize with readme and no *.gitignore*
```


A Git repository has now been created and is ready to be cloned as shown in {numref}`assignments_github_first_repo`. You can choose to clone either using SSH og HTTPS. If you know how to setup SSH keys, cloning the repository using SSH is generally favorable as you do not have to write your username and password everytime you clone or push. However, if you do not know how to use SSH keys, it is recommended to clone using HTTPS, but you will need to write your username and password everytime you clone or push.

```{figure} ../images/assignments_github_first_repo.png
---
width: 80%
align: center
name: assignments_github_first_repo
---
First view of newly create Git repository.
```

* Open a Git Bash terminal  window. (Windows start menu --> Git Bash) and navigate to the directory where you would like to clone the repository.  (On Linux or Mac open a standard terminal window).
* Copy the path to the repository and use the *git clone* command to download the repository's content.

```bash
git clone https://github.uio.no/FYS4220-2020/fys4220-lastname-firstname.git
```

* Navigate into the directory that was just created and open the readme file with your favorite text editor.
* Write the following headline:

```console
FYS4220 Git repository for <firstname> <lastname>
```

You are encouraged to use the readme file as a log for your work and to keep track of yor progress. The content of this file, as well as the code uploaded to your Git repository, will be the basis for the final evaluation and approval of the project.


A *.gitignore* file is used by Git to filter out files that are not subject to version control.
* To add this file write the following command inside the Git repository directory. Do not forget the leading punctuation mark.
```bash
touch .gitignore
```
A file with a leading punctuation mark is a hidden file and is normally not visible in a directory browser. In a terminal window you can write `ls -a` followed by enter to see the files in the directory. To view the file in the Windows File Explorer, enable *Show hidden files, folders and drivers* from the *View* tab of (File --> Change folder and search options).
* Open the *.gitignore* file and add the following lines and save the file.

```console
# ignore Quartus  generated folders
db/
incremental_db/
simulation/
timing/
*_sim/
output_files/

# ignore special files except .gitignore
.#*
\#*
*~
_*
.*
!.gitignore

# ignore Quartus generated files
*.rpt
```


* When you have completed this part, make sure to update the git repository by writing the following Git commands. Remember that at any point in the process you can write `git status` to see the current status of the Git repository.

```bash
git add .gitignore
git commit -am "Added .gitignore and updated readme.md"
git push origin master
```

Verify that you repository has been updated online.


```{admonition} Tip
:class:

If you would like check what a Git command is about to do, you can add the dry-run option:

```bash
git <command> --dry-run
```

The dry-run option will check what the git command is about to do, before actually doing so.```

```{admonition} Organisation and naming conventions
:class:
When working on the individual assignments and exercises, it is recommended to follow the suggested structure and naming of directories, files, signals, variable, constants, etc.. You are free to choose your own structure and names, but keep in mind that this will create a mismatch between your stucture and names, and that of the description. For some exercises you may make use of pre-made code, and you will therefore have to check if changes to this code isneeded to match your setup.
```

You are now ready to start working on the first assignment. Remember to update the assignment progess status in the readme file as you move forward, and whenever you start or complete an assignment problem.

## Using Git for FYS4220


If this is the first time you use Git on a computer you should "Tell Git who you are":

```console
$ git config --global user.name "Sam Smith"
$ git config --global user.email sam@example
```

Please use you UiO e-mail address.


_A normal command line based working flow:_
* Login to Github.uio.no
* Clone your repository *fys4220-lastname-firstname*:
```console
git clone https://github.uio.no/fys4220-2021/fys4220-lastname-firstname.git
```
* Edit and save a file (e.g., the readme file).
* Commit the change with a relevant/informative message:
```bash
git commit -am "Made changes to file README.md"
```
* Push these changes to the remote repository on Github.uio.no:
```bash
git push origin master
```
* The local copy of the repository can now be deleted if wanted.

%### Submitting the project assignments

%Submitting an assignment is simply done by creating a tag to mark/identify the code/project that you are submitting for evaluation, e.g:
%```
%git tag -a lab1-part1 -m "Completed part 1 of lab 1"
%git push origin lab1-part1
%```
%where lab1-part1 is the name of the tag id.

%Information on when to tag and and which tag name to be used will %be given in the as part of the lab. instructions.





%======= Working with issues =======
%* An overview of how to use issues can be found here: "https://help.github.com/articles/managing-your-work-with-issues/":"https://help.github.com/articles/managing-your-work-with-issues/".
