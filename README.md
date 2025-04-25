Original App Design Project - README Template
===

# SafeSpot

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

## Overview

### Description

Find a spot nearby to calm down

### App Evaluation

[Evaluation of your app across the following attributes]
- **Category:** Lifestyle
- **Mobile:** Mobile needed for real-time location updates
- **Story:** For people who need a calming place
- **Market:** Anyone feeling uneasy in a new location/ people who are stressed 
- **Habit:** Once a week, depends how often you need to separate/ go into a relaxed environment 
- **Scope:**

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* View Map
    - [x] view map
* ViewRelaxingSpots
    - [ ] open app and see recommended spots to go to
* Get directions to relaxing spot
    - [ ] able to get directions to place you want to go to

**Optional Nice-to-have Stories**

* Favorites
    - [ ] Save areas to profile

### 2. Screen Archetypes

- [x] DisplayMap
    - [x] Will be able to see map

- [x] SeePlaces
    - [ ] Will view places that are relaxing like a cafe

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Main Map
* Profile


**Flow Navigation** (Screen to Screen)

- [ ] Main Map View Controller will go to Profile view
    - [ ] Profile
- [ ] Profile view will go to Main Map View Controller
    - [ ] Main Map

## Wireframes

[Add picture of your hand sketched wireframes in this section]
<img src="YOUR_WIREFRAME_IMAGE_URL" width=600>
* Didn't make wireframe sorry

## DEMO
<img style="max-width:400px;" src="https://previews.jumpshare.com/gif/815bc01b796dd6f1733c957c5af194933f720f2be2c32e5544b35fc323763f4a778fbc2ee8de6d1f48ff3bc4b2d2cc9e3b948c10bacda0a46174d12beca67b22c9067d658f62a27d2c325725f916e731">

[https://previews.jumpshare.com/gif/815bc01b796dd6f1733c957c5af194933f720f2be2c32e5544b35fc323763f4a778fbc2ee8de6d1f48ff3bc4b2d2cc9e3b948c10bacda0a46174d12beca67b22c9067d658f62a27d2c325725f916e731](https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExc2sxejhkbzl5dXF5ZnkyOGZ6am94OGdqa2w4cXlkMW1sNWJxODBxbSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/yX1XqUvrxeBVGvOsEk/giphy.gif)

### [BONUS] Digital Wireframes & Mockups


## Schema 

[This section will be completed in Unit 9]
- [ ] Unsure what to put here sorry again

### Models

- I have a data model of LocationSpots to store api data.

### Networking

- ViewController calls fetchData() to get api request information
- Snippit of fetchdata()
```swift
    func fetchData() {
        let url = URL(string: "https://api.geoapify.com/v2/places?categories=catering.cafe&filter=circle:-73.9712,40.7831,7000&limit=5&apiKey=...")!
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {...
```
