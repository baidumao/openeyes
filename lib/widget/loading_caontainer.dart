import 'package:flutter/material.dart';
class LoadContainer extends StatelessWidget {
  final Widget child;
  final bool loading;
  final bool cover;

  LoadContainer({this.child, this.loading, this.cover=false});

  @override
  Widget build(BuildContext context) {
    return !cover
        ? !loading ? child : _loadView
        : Stack(
      children: <Widget>[child, loading ? _loadView : null],
    );
  }

  Widget get _loadView {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
