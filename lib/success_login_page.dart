import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SuccessLoginPage extends StatefulWidget {

  final String profileImage;
  final String fbName;
  final String fbEmail;
  final String fbId;
  final String fbAccessToken;
  const SuccessLoginPage({ Key? key,
    required this.fbAccessToken,
    required this.fbId,
    required this.fbEmail,
    required this.fbName,
    required this.profileImage
  }) : super(key: key);

  @override
  State<SuccessLoginPage> createState() => _SuccessLoginPageState();
}

class _SuccessLoginPageState extends State<SuccessLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("FACEBOOK SIGNED IN SUCCESSFULLY", style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15),),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [

        //display image from network, here we will show profile image from fb
        ClipRRect(
          borderRadius: BorderRadius.circular(100),// to make the profile image round
          child: CachedNetworkImage(
              imageUrl:  widget.profileImage,
              progressIndicatorBuilder: (context, url, downloadProgress) => 
                      CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
        SizedBox(height: 10,),
        Text(widget.fbName, style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600
        ),), //display name of signed in account
        SizedBox(height: 10,),
        Text(widget.fbId, style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600
        ),), //display id of signed in account
        SizedBox(height: 10,),
        Text(widget.fbEmail, style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600
        ),), 
        SizedBox(height: 10,),
        Text(widget.fbAccessToken, style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600
        ),), 
      ],
    );
  }
}