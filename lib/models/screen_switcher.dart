import 'package:flutter/material.dart';

class ScreenSwitcher {
  List<ScreenData> screenDataList = [];
  int currentIndex = 0;

  ScreenSwitcher(this.screenDataList);

  void setScreenDataList(List<ScreenData> screenDataList) {
    this.screenDataList = screenDataList;
  }

  void setIndex(int index) {
    currentIndex = index;

  }

  void addScreenData(ScreenData screenData) {
    screenDataList.add(screenData);
  }

  ScreenData getCurrentScreen() {
    if(screenDataList.isEmpty)
      return errorScreenData("Error: Screen data list is empty");
    return screenDataList[currentIndex];
  }

  ScreenData getScreenDataByIndex(int index) {
    if(index >= screenDataList.length) {
      return errorScreenData("Error: Screen data list is empty");
    }
    currentIndex = index;
    return screenDataList[index];
  }

  ScreenData errorScreenData(String text) {
    return ScreenData(widget: Text(text), icon: Icon(Icons.disabled_by_default), name: "Error");
  }

  List<BottomNavigationBarItem> getBotNavItemList() {
    List<BottomNavigationBarItem> list = [];
    for(int i=0; i<screenDataList.length; i++) {
      list.add(BottomNavigationBarItem(icon: screenDataList[i].icon, label: screenDataList[i].name));
    }
    return list;
  }
}

class ScreenData {
  Widget widget;
  Icon icon;
  String name;

  ScreenData({
    required this.widget,
    required this.icon,
    required this.name,
  });
}