Original App Design Project - README Template
===

# Morgan Social

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Morgan Social is an app strictly for Morgan State Students that provides news, events, opinions on certain matters, clubs/orgs, meeting other students, etc. What's great about this app is that everything is ran by the students! Everything about how people feel about food, dorms, professors, and the overall Morgan experience would be expressed by the students. I feel like as a student, I would much rather hear from another student about how they feel about a school than someone who was hired to say only positive things (pew pew pew shots fired). The good thing about this is that you can showcase your small business, you can create an unofficial club, etc.

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Social
- **Mobile:**
    - easy to use
    - compact
    - more suited for mobile 
- **Story:**
    - value of app is really clear
    - get to know what's going on at school
    - everything in one
- **Market:**
    - Only Morgan State Students
- **Habit:**
    - Get on it every now and then to check out what's happening at school
- **Scope:**
    - the amount of features is endless, but the basics of it can be done

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* You can only login with a morgan.edu email
* You can post in an opinions community anonymously
* ability to create a club/org and post it in the clubs section
* profile page
* log in, log out, and sign up page
* delete posts
* like/unlike posts
* profile picture (camera feature alongside)
* have a mini bio with your major and classification
* messages

**Optional Nice-to-have Stories**

* bullying/profanity filter
* a verified club/org feature
* notification section
* group messaging
* friends list
* settings page
* search topics

### 2. Screen Archetypes

* login/signup screen
   * log in, log out, and sign up page
   * You can only login with a morgan.edu email
* trending topics on the home page
   * You can post in an opinions community anonymously
   * delet posts
   * like/unlike posts
   * ability to create a club/org and post it in the clubs section
* profile page
    * profile page
    * have a mini bio with your major and classification

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* [Home]
* [Search topics]
* [Messages]
* [Profile page]

**Flow Navigation** (Screen to Screen)
* Forced Log-in -> Account creation if no log in is available
* Search Topics -> Get's list of topics
* Profile -> Able to edit profile picture and bio.
* Messages -> Compose or reply to any messages


## Wireframes
[Add picture of your hand sketched wireframes in this section]

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]
### Models
Post
| Property      | Type            | Description                                         |
| ------------- | --------------- | --------------------------------------------------- |
| objectId      | String          | unique id for the user post (default field)         |
| author        | Pointer to User | image author                                        |
| image         | File            | image that user posts                               |
| caption       | String          | image caption by author                             |
| commentsCount | Number          | number of comments that has been posted to an image |
| likesCount    | Number          | number of likes for the post|
| createdAt | DateTime | date when post is created(default field)|
| updatedAt | DateTime | date when post is last updated (default field)|
| category | String | the category in which the post falls under |

User
| Property | Type | Description |
|----------| ------| ----------|
| objectId      | String          | unique id for user       |
| emailVerified        | Bool | to verify email                                       |
| profilePhoto         | File            | image that the user has                              |
| ACL       | ACL          | no clue                            |
| updatedAt |Date          | shows when user was created |
| username    | String          | the name of the user|
| password | String | password for user|
| email | String | the email of the user|



### Networking

- Home Feed Screen
    - (Read/GET) Query all posts where it ranks the number of likes.
    
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"likesCount"];
    [query includeKey:@"author"];
    [query includeKey:@"category"];
    query.limit = 10;
    
    - (Create/POST) Create a new like on a post.
    - (Delete) Delete existing like.
    - (Create/POST) Create a new comment on a post.
    - (Delete) Delete existing comment.
- Create Post Screen
    - (Create/POST) Create a new post object.
- Profile Screen
    - (Read/GET) Query logged in user object.
    - (Update/PUT) Update user profile image.
