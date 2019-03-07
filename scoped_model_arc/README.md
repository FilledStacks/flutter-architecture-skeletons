# Flutter using Scoped Model

In this folder you will find an example application that contains the bare minimum for using Flutter with the ScopedModel architecture. As with the other examples, this is not a comprehensive guide on how to use ScopedModel . Instead look at it as a code guideline that can be used when applying the articles you've read about ScopedModel. Where to put your files, what logic goes where and how to keep your states and UI separate and well organized.

## Getting Started

1. Clone this repo and make a copy of this folder
2. Drag this folder into you Visual Studio code editor to open a workspace
3. Press Ctrl+Shift+F, type in scoped_model_arc, drop down the find box and perform a replace using the app name you want
4. Start developing

## Structure and placement

The root folder is split into 4 sections, models, scoped_models, services and ui.

### Models

Contains all the application's data models.

### Scoped Models

In here you will have your AppModel (Main state model) with all the additional Mixins to add behaviour to the main Scoped Model. These models will use the services and translate it's responses into usable state information for the views that are currently visible. There are two mind sets when creating service mixins and they depend on the size and amount of business logic you require.

- **Each scoped model represents a page state:** With this way of handling it you will have your pages state properties exposed and functions to manipulate / update that state. Each page will have it' own scoped model so there's some separation in terms of functionality.
- **Each model represents a functionality state:** This way works good if you have an application where a lot of the same info will be shared across related screens. For example a user profile that gets displayed in 2 or more screens. You won't want the same user profile property duplicated over several page states, instead you just have one user_model.dart that contains and maintains the state of user info in the application.

You can choose how you want to handle your app, it all depends on the size and how granular you want things to be. I have used both the model as page state and functionality state. Page state is cleaner with more files and functionality state has less files and more combined / wholesome code files. But can quickly become messy.

**Naming convention:** [feature/pagename]_model.dart user_model.dart or home_model.dart

### Services

This will contain separate services / components or whatever you call it that performs additional functionality for you. For example a persistence service which will save all your data to disk, a user service which will track the current user info and manage user data, login service, etc. These are usually built using the singleton pattern so that different parts of the app have the same instance to work with. See example service in the folder.

**Naming convention:** [functionality]_service.dart

### UI

Contains all the code relating to the user interface. Flutter is a code first approach to building UI (which is great) so all the code files can live together in harmony without having to fuss about if it's an asset or a code file like in native programming. We only have one folder (as a start) and with more code I usually introduce a components folder as well as a util folder for shared UI helper functions. The structure is as follows.

**pages/**: Contains the files for each of the pages in your applications.

Naming convention: [viewname]_page.dart

## Feedback and contemplation

f you want to weigh in on any code conventions or mistakes you might have found in the code please do. Open an issue and describe what you're thinking of and I'll get to it and start a discussion with you. I appreciate you taking the time to read this and I hope I've brought you some kind of value. 