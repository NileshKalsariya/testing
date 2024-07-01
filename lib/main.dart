import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

void main() {
  // changes from n
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo n',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: HomeScreen());
  }
}

class HomeController extends GetxController {
  @override
  void onInit() {
    copy.value = initialList;
    copy.refresh();
    super.onInit();
  }

  RxString data = RxString("");

  RxList<SelectionModel> copy = RxList([]);

  RxList<SelectionModel> initialList = RxList([
    SelectionModel(name: "1", selected: false, id: "1"),
    SelectionModel(name: "2", selected: false, id: "2"),
    SelectionModel(name: "3", selected: false, id: "3"),
    SelectionModel(name: "4", selected: false, id: "4"),
    SelectionModel(name: "5", selected: false, id: "5"),
    SelectionModel(name: "6", selected: false, id: "6"),
    SelectionModel(name: "7", selected: false, id: "7"),
    SelectionModel(name: "8", selected: false, id: "8"),
    SelectionModel(name: "9", selected: false, id: "9"),
    SelectionModel(name: "10", selected: false, id: "10"),
    SelectionModel(name: "11", selected: false, id: "11"),
  ]);

  RxList<String> ids = RxList([]);

  saveData() {
    for (var element in initialList) {
      if (ids.contains(element.id)) {
        element.selected = true;
      } else {
        element.selected = false;
      }
    }
  }

  cancel() {
    initialList.value = copy.value;
    ids.value = [];
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<HomeController>(
        init: HomeController(),
        builder: (HomeController controller) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.initialList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: controller.initialList[index].selected == true
                          ? Text(controller.initialList[index].name ?? "")
                          : const SizedBox(),
                    );
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.copy.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        controller.copy[index].selected =
                            !(controller.copy[index].selected ?? false);
                        if (controller.copy[index].selected == true) {
                          controller.ids.add(controller.copy[index].id ?? "");
                          controller.ids.refresh();
                        }
                      },
                      child: ListTile(
                        title: Text(controller.copy[index].name ?? ""),
                        trailing: controller.copy[index].selected == true
                            ? Icon(Icons.check)
                            : null,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 100,
              ),
              InkWell(
                  onTap: () {
                    controller.cancel();
                  },
                  child: Text("cancel")),
              InkWell(
                  onTap: () {
                    controller.saveData();
                  },
                  child: Text("save")),
            ],
          );
        },
      ),
    );
  }
}

class SelectionModel {
  String? name;
  bool? selected;
  String? id;

  SelectionModel({this.name, this.selected, this.id});

  SelectionModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    selected = json['selected'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['selected'] = this.selected;
    data['id'] = this.id;
    return data;
  }
}
