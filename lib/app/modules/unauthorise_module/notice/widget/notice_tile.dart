import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:school_management_app/app/common/style.dart';

class NoticeTile extends StatelessWidget {
  final String ?title;
  final String ?descrption;
  final String ?images;
  final String ?time;
  const NoticeTile({super.key,  this.descrption, this.images, this.title, this.time});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: primaryColor.withOpacity(0.2), width: 1),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
         decoration: const BoxDecoration(
            borderRadius:  BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight:  Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
              color: lWhite
          ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment:CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title.toString() ,
                    style: const TextStyle(
                      color:  primaryColor, 
                      fontSize: 18.0, 
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  Text(time.toString(),
                    style: const TextStyle(
                      color:  lGrey2, 
                      fontSize: 12.0, 
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(descrption.toString(),
                     style: const TextStyle(
                        color:  lGrey2, 
                        fontSize: 12.0, 
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                  CachedNetworkImage(
                    height: 100,
                    width: 120,
                      imageUrl: images.toString(),
                      placeholder: (context, url) => const CircularProgressIndicator(
                        strokeWidth: 10.0,
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ],
              ),
            
          ]),
        ),
      ),
    );
  }
}