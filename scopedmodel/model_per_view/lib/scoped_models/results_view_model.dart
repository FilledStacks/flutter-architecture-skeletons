import 'dart:async';
import 'package:scoped_model/scoped_model.dart';
import 'package:model_per_view/services/web_service.dart';
import 'package:model_per_view/models/list_item.dart';
import 'package:model_per_view/service_locator.dart';
import 'base_model.dart';

export 'package:model_per_view/enums/view_state.dart';


/// Contains logic for a list view with the general expected functionality.
class ResultsModel extends BaseModel {

  WebService _webService = locator<WebService>();

  List<ListItem> listData;

  Future fetchListData() async {
    setState(ViewState.Busy);

    listData = await _webService.fetchData();

   if (listData == null) {
      setState(ViewState.Error);
    } else {
      setState(listData.length == 0
          ? ViewState.NoDataAvailable
          : ViewState.DataFetched);
    }
  }
}