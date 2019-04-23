### About this template

There are two mind sets when creating an app using ScopedModel, that I've seen. In both of these the actual work is delegated to services. The model just uses services and it's functionality to produce the correct state for the app UI based on the user's interactions.

#### One AppModel with FeatureModel mixins 
In this way you have one [AppModel that extends Mixins](https://github.com/FilledStacks/flutter-architecture-skeletons/scopedmodel/single_appmodel/lib/scoped_models), that are also of type Model but groups all the functionality for a feature together. UserModel, AuthenticationModel, InformationModel, etc. You pass the combined AppModel from the top of your application widget tree and access it anywhere in the app using the ScopedModelDescendent.

**Pros:**
  - State is managed in one place (and all the benefits of that).
  - All functionality is Easily accessible from one model using inherited widget functionality.
  - Combining multiple functionalities can be done in the Main AppModel class since all feature models functionalities are available through the mixins.

**Cons:**
  - notifyListeners can have multiple bindings alive at any point.
  - All state is reduced per view without any clear indication inside the model which parts of the state is there for a specific view. 
  - View specific models has to keep a reference to the main AppModel incase of custom view only state functionality. Like views that have 3 different internal states for different UI.

#### One Model per view

**Pros:**
  - Each view has it's own dedicated Model
  - All state functionality and reduction for a view is contained in it's own Model
  - Better logical and mental grouping (View + View's Model)

**Cons:**
  - More Models to be aware of and manage
  - More boiler plate code when creating a new view ([appskeletons](https://www.appskeletons.com) can take care of that :)
  - Harder to make use of Logic from other models (which should never happen anyway)

I have implemented my first production Flutter app for a client using ScopedModel with the first structure I described. This folder contains both implementations.
