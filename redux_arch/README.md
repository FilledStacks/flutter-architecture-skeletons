# Flutter using Redux

This folder contains the code that I use personally to start a new Flutter application that uses the redux architecture. It's **not** meant to be a comprehensive guide on using Redux in Flutter. Once you have read articles like [this one](https://blog.novoda.com/introduction-to-redux-in-flutter/) that gives you a great overview of everything, or [this one](https://proandroiddev.com/implementing-redux-architecture-with-flutter-dd28640dd945) which shows a bit more code then you can come here and use this template. If you don't understand the concept behind redux please read up on it a bit more, build a demo application yourself and then get this template when you want to speed things up the next time around.

## Getting Started

1. Clone this repo and make a copy of this folder
2. Drag this folder into you Visual Studio code editor to open a workspace
3. Press Ctrl+Shift+F, type in redux_arc, drop down the find box and perform a replace using the app name you want
4. Start developing

## Structure and placement

This code structure separates the main source folder lib/ into three sections. Models, Redux and Ui. These are not the only folders that I usually have in a redux application, but it's the three ones you need to get the application structure idea accross.

### Models
Contains all the data models that will be used in the application. It's a separate and outside of both ui and redux because it's used within both of those packages to the same degree.

### Redux
Contains all the Redux related code files. 

**actions/:** Stores all the redux actions required for the application to run. One file usually stores all the actions relating to certain category. A category can be a feature a view or a set of functionalities, for example, persistence_actions.dart will store all the actions relating to your persistence layer. AddNewDataToDB, RemoveDataFromDB, UpdateDataInDB etc. 

Naming convention: [category]_actions.dart

**app_state.dart:** Stores the entire application state

**middleware.dart:** An example of how middleware is implemented. I would personally separate middleware into a folder as well and have files specific to certain middleware functionality to keep things more organized

**reducers.dart:** An example of how reducers are written. The same as middleware, once this gets bigger and involve multi feature/functionality reducing I would create a reducers folder and move all my reducers in there to keep everything organized.

### Ui
Contains all the code relating to the user interface. Flutter is a code first approach to building UI (which is great) so all the code files can live together in harmony without having to fuss about if it's an asset or a code file like in native programming. We only have two folders (as a start) and with more code I usually introduce a components folder as well as a util folder for shared UI helper functions. The structure is as follows.

**viewmodels/:** In mose cases, depending on how small or large your view is you can keep the ViewModel and view in the same file. This is how the tutorials teach you to handle it, but with just some basic functinoality the viewmodel quickly takes up too much space and it makes it harder to navigate to using file jump. For those reasons I separate them in this template. 

Naming convention: [viewname]_viewmodel.dart

**views/:** Contains the files for each of the views in your applications a view being one complete application page. Each page will have it's own dedicated file. I'm calling it a view to be consistent with the viewmodel part of redux

Naming convention: [viewname]_view.dart

## Feedback and contemplation

There are a few things up for debate in my head which I would like some input on if you don't mind.

**AppState:** This is technically just a model right? Does it belong in the redux folder or in the models folder. It has no redux functionality on it, there's no references to any redux libs in it, it is a pure model. The only reason it lives in the redux folder is because I feel better about it being there but I don't know if it makes logical sense. I had a similar feeling about Actions when I started but then realised even thought the code has the structure of a model, it's not used as models meaning not used as a representation of data or a structure in the app, it is infact just a redux action/command.

If you want to weigh in on the AppState issue I have you can just open an issue with title **AppState placement** and then type your issues out there. If you want to suggest anything else please do the same in issues and I'll get back to you as soon as I'm available.