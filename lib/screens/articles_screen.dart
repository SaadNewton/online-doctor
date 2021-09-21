//@dart=2.9
import 'package:doctoworld_doctor/Components/custom_dialog.dart';
import 'package:doctoworld_doctor/Theme/colors.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:doctoworld_doctor/repositories/getArticlesRepo.dart';
import 'package:doctoworld_doctor/screens/add_article_screen.dart';
import 'package:doctoworld_doctor/screens/update_article_screen.dart';
import 'package:doctoworld_doctor/services/get_method_call.dart';
import 'package:doctoworld_doctor/services/post_method_call.dart';
import 'package:doctoworld_doctor/services/service_urls.dart';
import 'package:doctoworld_doctor/storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArticlesScreen extends StatefulWidget {
  @override
  _ArticlesScreenState createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<LoaderController>().updateDataController(true);
    });
    getMethod(
        context,
        getAllArticlesService,
        {'doctor_id': storageBox.read('doctor_id')},
        true,
        getAllLArticlesRepo);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoaderController>(
      init: LoaderController(),
      builder:(loaderController)=> Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          title: Text(
            'My Articles',
          ),
          textTheme: Theme.of(context).textTheme,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: (){
                  Get.to(AddArticleScreen());
                },
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: primaryColor,
                  child: Icon(
                      Icons.add,
                      color:Colors.white),
                ),
              ),
            )
          ],
        ),
        body: loaderController.dataLoader
            ? Center(child: CircularProgressIndicator())
            : getArticlesModel.data == null
            ? Container(
          child: Center(
              child: Text(
                'Record Not Found',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(fontWeight: FontWeight.w600),
              )),
        )
            : Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Wrap(
                  children: List.generate(getArticlesModel.data.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 9,
                                    spreadRadius: 2
                                  )
                                ]
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    getArticlesModel.data[index].image == null
                                        ?SizedBox()
                                        :Image.network(
                                      '$mediaUrl${getArticlesModel.data[index].image}',
                                      width: MediaQuery.of(context).size.width*.3,
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Text(
                                          '${getArticlesModel.data[index].title}',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            '${getArticlesModel.data[index].description}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              right: 0,
                              bottom: 0,
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      showDialog(
                                          context: context,
                                          builder:
                                              (BuildContext context) {
                                            return CustomDialogBox(
                                              titleColor:
                                              customDialogQuestionColor,
                                              descriptions:
                                              'Are you sure You want to delete this article?',
                                              text: 'Remove',
                                              functionCall: () {

                                                Get.find<LoaderController>().updateDataController(true);
                                                postMethod(
                                                    context,
                                                    deleteArticlesService,
                                                    {
                                                      'delete_id':getArticlesModel.data[index].id
                                                    },
                                                    true,
                                                    deleteArticlesRepo
                                                );
                                                Navigator.pop(context);
                                                setState(() {});
                                              },
                                              img:
                                              'assets/dialog_Question Mark.svg',
                                            );
                                          });
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 40,
                                      color: Colors.red,
                                      child: Center(child: Icon(Icons.delete,
                                        color: Colors.white,),),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      Get.to(UpdateArticleScreen(getArticlesModelData: getArticlesModel.data[index],));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(10))
                                      ),
                                      height: 30,
                                      width: 40,
                                      child: Center(child: Icon(Icons.edit,
                                        color: Colors.white,)),
                                    ),
                                  )
                                ],
                              ))
                        ],
                      ),
                    );
                  }),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}
