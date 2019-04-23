import 'package:flutter/material.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";

import 'package:model_per_view/models/list_item.dart';
import 'package:model_per_view/scoped_models/results_view_model.dart';
import 'package:model_per_view/ui/shared/font_styles.dart';
import 'package:model_per_view/ui/shared/app_colors.dart';
import 'package:model_per_view/ui/shared/ui_helpers.dart';
import 'package:model_per_view/ui/views/base_view.dart';

class ResultsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<ResultsModel>(
        onModelReady: (model) => model.fetchListData(),
        builder: (context, childe, model) => Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: Container(child: _getBodyUi(context, model))));
  }

   Widget _getBodyUi(BuildContext context, ResultsModel model) {
    switch (model.state) {
      case ViewState.Busy:
        return _getLoadingUi(context);
      case ViewState.NoDataAvailable:
        return _noDataUi(context, model);
      case ViewState.Error:
        return _errorUi(context, model);
      case ViewState.DataFetched:
      default:
        return _getListUi(model);
    }
  }

  Widget _getListUi(ResultsModel model) {
    return SmartRefresher(
      enablePullDown: true,
      headerBuilder: (buildContext, int) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.arrow_downward, color: Colors.white, size: 30.0),
              UIHelper.horizontalSpaceSmall(),
              Text('Refresh Data')
            ],
          ),
      onRefresh: (bool up) {
        if (up) {
          // NOTE: If you want to keep the list visible while refreshing change this logic here
          // and do some custom work.
          model.fetchListData();
        }
      },
      child: ListView(
          children: model.listData
              .map((result) => GestureDetector(
                  onTap: () {
                    // Perform your custom logic here
                    print('List item tapped: ${result.title}');
                  },
                  child: _getListItemUi(result)))
              .toList()),
    );
  }

  Container _getListItemUi(ListItem result) {
    return Container(
      height: 100.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), color: lightGrey),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(result.title, style: viewTitle),
          Text(result.description)
        ],
      ),
    );
  }

  Widget _getLoadingUi(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
        Text('Fetching data ...')
      ],
    ));
  }

  Widget _noDataUi(BuildContext context, ResultsModel model) {
    return _getCenteredViewMessage(
      context, 
      "No data available yet",
      model);
  }

  Widget _errorUi(BuildContext context, ResultsModel model) {
    return _getCenteredViewMessage(
        context, 
        "Error retrieving your data. Tap to try again",
        model,
        error: true);
  }

  Widget _getCenteredViewMessage(
    BuildContext context, 
    String message,
    ResultsModel model,
      {bool error = false}) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            message,
            style: viewErrorTitle,
            textAlign: TextAlign.center,
          ),
          error
              ? GestureDetector(
                  onTap: () {
                    model.fetchListData().catchError((error) {
                      print('Retry to fetch your data has failed.');
                    });
                  },
                  child: Icon(
                    Icons.refresh,
                    color: Colors.white,
                    size: 45.0,
                  ))
              : Container()
        ],
      ),
    ));
  }
}
