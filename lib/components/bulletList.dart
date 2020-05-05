import 'package:flutter/material.dart';
import 'package:remap/utils/constants.dart';
import 'package:remap/utils/utils.dart';

class BulletList extends StatefulWidget {
  final List<String> options;
  final bool isSecondary;
  final bool isMultiSelectable;
  final Function callBack;

  /// CallBack is used to elevate the state of the selected list, so it needs a boolean list as parameter
  /// Function callback = (List<bool> itemsSelected) => {print(itemsSelected)};

  BulletList(
      {Key key,
      this.options,
      this.isSecondary = false,
      this.isMultiSelectable = false,
      this.callBack})
      : super(key: key);

  @override
  _BulletListState createState() => _BulletListState();
}

class _BulletListState extends State<BulletList> {
  List<ListItem<String>> list;

  Widget _getListItemTile(BuildContext context, int index) {
    var txtData = Text(list[index].data,
        style: TextStyle(
            fontSize: MyConstants.of(context).midTitleSize,
            fontWeight: MyConstants.of(context).fontLight,
            color: widget.isSecondary
                ? MyConstants.of(context).colorGray
                : Colors.black));

    var iconSelected = list[index].isSelected
        ? Icon(Icons.adjust,
            color: widget.isSecondary
                ? Theme.of(context).accentColor
                : Theme.of(context).primaryColor)
        : Icon(Icons.panorama_fish_eye, color: Colors.grey);

    Function funcMultiSelectable = () => {
          setState(() {
            list[index].isSelected = !list[index].isSelected;
          })
        };

    Function funcNotMultiSelectable = () => {
          setState(() {
            for (int i = 0; i < list.length; i++) {
              list[i].isSelected = false;
            }
            list[index].isSelected = true;
          })
        };

    return ListTile(
      title: txtData,
      trailing: iconSelected,
      onTap: () {
        widget.isMultiSelectable
            ? funcMultiSelectable()
            : funcNotMultiSelectable();
        List<bool> booleanList = List<bool>();
        for (ListItem i in list) {
          booleanList.add(i.isSelected);
        }
        widget.callBack(booleanList);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    populateData();
  }

  void populateData() {
    list = [];
    for (int i = 0; i < widget.options.length; i++) {
      list.add(ListItem<String>(widget.options[i]));
    }
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: getResponsiveDps(305, width),
      child: ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: list.length,
        itemBuilder: _getListItemTile,
      ),
    );
  }
}

class ListItem<T> {
  bool isSelected = false; //Selection property to highlight or not
  T data; //Data of the user
  ListItem(this.data); //Constructor to assign the data
}
