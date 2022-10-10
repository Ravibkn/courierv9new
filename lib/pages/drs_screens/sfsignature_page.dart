// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_final_fields, library_prefixes, non_constant_identifier_names, avoid_init_to_null, annotate_overrides, use_build_context_synchronously, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

// import 'package:first_work/pages/drs_screens/photo_page.dart';
import 'package:courierv9/pages/global.dart';
import 'package:courierv9/pages/style_constent.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:path_provider/path_provider.dart';

import '../components/custom_button.dart';
import '../palette.dart';
import '../routs.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';



import 'dart:ui' as ui;
import 'dart:io' as Io;

class SfSignnature extends StatefulWidget {
  final Map<String, dynamic>? args;

  const SfSignnature(this.args, {Key? key}) : super(key: key);

  @override
  State<SfSignnature> createState() => _SfSignnatureState();
}

class _SfSignnatureState extends State<SfSignnature> {
  
  var isLoading =true;
  var slip_no =null;
  var drs_unique_id = null;
  var VerifiedBy =null;
  var signature_image = null;
  var receiver_image = null;

  void initState() {
    super.initState();
    //print(widget.args);
      getAppData(widget.args);
  }
   Future<void> getAppData(arguments) async {

      setState(() {
        slip_no = arguments['slip_no'];
        drs_unique_id = arguments['drs_unique_id'];
        VerifiedBy = arguments['VerifiedBy'];
        isLoading =false;
      });

   }
  File? image;
    final _formkey = GlobalKey<FormState>();

  TextEditingController receiverNameController =
      TextEditingController(text: '');
  TextEditingController receiverNumberController =
      TextEditingController(text: '');

  
 


  GlobalKey<SfSignaturePadState> _signnaturePadKeyState = GlobalKey();
   
  Future _openGallary(BuildContext context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return Navigator.of(context).pop();

    final imageTemporary = File(image.path);

    final bytes = await Io.File(image.path).readAsBytes();
    String img64 = base64Encode(bytes);
    setState(() {
      this.image = imageTemporary;
      receiver_image = img64;
    });
    Navigator.of(context).pop();
  }

  Future _openCamera(BuildContext context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return Navigator.of(context).pop();

    final imageTemporary = File(image.path);

    final bytes = await Io.File(image.path).readAsBytes();
    String img64 = base64Encode(bytes);

    setState(() {
      this.image = imageTemporary;
      receiver_image = img64;
    });
    Navigator.of(context).pop();
  }

  Future<void> _showChooseDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Make a Choise"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Gallary"),
                    onTap: () {
                      _openGallary(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8)),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }
   Future<void> updateDrs() async {
      try{
       
         if (_formkey.currentState!.validate()) {

            var d_name = receiverNameController.text;
            var d_phone = receiverNumberController.text;
           
           if(signature_image != null && receiver_image !=null){
            setState(() {
              isLoading = true;
            });
                var res = await http.post(
          Uri.parse(baseUrl + 'rest_api_native/RestController.php'),
          body: {
                "view":'take_sign',
                "sign_image":signature_image,
                "receiver_image":receiver_image,
                "drs_unique_id": slip_no,
                "name":d_name,
                "mobile":d_phone,
                "VerifiedBy":VerifiedBy,
          });
           setState(() {
              isLoading = false;
            });
            if(res.statusCode==200){

               var resultData = jsonDecode(res.body);
               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Update Successful!")));
               Navigator.pushNamed(context, MyRouts.drsListRout);
            }
            else{
                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Ooops Somthings Went Wrong!")));
            }
           }
          
         }
      }
      catch(err){
                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${err}")));
      }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading == false ?
        Column(
        children: <Widget>[
        SizedBox(
          height: 50,
        ),
        Container(
          height: 310,
          width: 400,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300, width: 2),
              color: Colors.white,
              borderRadius: BorderRadius.circular(17)),
          child: Column(
            children: [
              Container(
                width: 400,
                height: 35,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          15,
                        ),
                        topRight: Radius.circular(15))),
                child: Center(
                    child: Text(
                  "Signnature",
                  style: mTextStyle2,
                )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SfSignaturePad(
                  key: _signnaturePadKeyState,
                  strokeColor: Colors.black,
                  backgroundColor: Colors.white,
                  minimumStrokeWidth: 4.0,
                  maximumStrokeWidth: 6.0,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                  text: "Save",
                  onTap: () async {
                    ui.Image image =
                        await _signnaturePadKeyState.currentState!.toImage();

                    final byteData =
                        await image.toByteData(format: ui.ImageByteFormat.png);
                    final Uint8List imageByts = byteData!.buffer.asUint8List(
                        byteData.offsetInBytes, byteData.lengthInBytes);

                    final String path =
                        (await getApplicationSupportDirectory()).path;
                    final String filename = '$path/Output.png';
                    final File file = File(filename);

                    final bytes = await Io.File(filename).readAsBytes();
                    String img64 = base64Encode(bytes);
                    setState(() {
                      signature_image = img64;
                    });
                    //print(signature_image);
                    // await file.writeAsBytes(imageByts, flush: true);
                    // OpenFile.open(filename);
                  }),
              CustomButton(
                  text: "Reset",
                  onTap: () async {
                    _signnaturePadKeyState.currentState!.clear();
                  }),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.grey.shade300, width: 2),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(17)),
                    child: Column(
                      children: [
                        Container(
                          width: 400,
                          height: 35,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                    15,
                                  ),
                                  topRight: Radius.circular(15))),
                          child: Center(
                              child: Text(
                            "Photo Preview",
                            style: mTextStyle2,
                          )),
                        ),
                        Container(
                          color: Colors.white,
                          height: 300,
                          child: image != null
                              ? Image.file(image!)
                              : Center(
                                  child: CustomButton(
                                    text: "Take Photo",
                                    onTap: () {
                                      _showChooseDialog(context);
                                    },
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: receiverNameController,
                        obscureText: false,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.supervised_user_circle,
                              color: Palette.iconColor,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Palette.textColor1),
                              borderRadius: BorderRadius.all(Radius.circular(35)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Palette.textColor1),
                              borderRadius: BorderRadius.all(Radius.circular(35)),
                            ),
                            contentPadding: EdgeInsets.all(10),
                            hintText: 'Delivered To Name',
                            hintStyle: TextStyle(
                                fontSize: 14, color: Palette.textColor1)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Username Cannot Be Empty";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: receiverNumberController,
                        obscureText: false,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.mobile_off_outlined,
                              color: Palette.iconColor,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Palette.textColor1),
                              borderRadius: BorderRadius.all(Radius.circular(35)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Palette.textColor1),
                              borderRadius: BorderRadius.all(Radius.circular(35)),
                            ),
                            contentPadding: EdgeInsets.all(10),
                            hintText: 'Delivered Phone',
                            hintStyle: TextStyle(
                                fontSize: 14, color: Palette.textColor1)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Username Cannot Be Empty";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                        text: "Deliver Drs",
                        onTap: () {
                          updateDrs();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
      ):
      Center(
                child: Lottie.asset("images/delivery-loader.json",
                    width: 150, height: 150),
              ),
    );
  }
}
