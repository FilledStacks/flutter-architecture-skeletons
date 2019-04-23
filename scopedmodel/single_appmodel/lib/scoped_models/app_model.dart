import 'package:scoped_model/scoped_model.dart';
import 'package:scoped_model_arc/scoped_models/example_model.dart';

/// App model is a collection os other models that have specific behaviours.
/// Usually models represnt features but it can be a model per view as well
/// Models make use of services that has actual functionality in it. The models
/// itself contains the app state
class AppModel extends Model with ExampleModel {
  
}