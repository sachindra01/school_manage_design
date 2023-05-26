import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:school_management_app/app/common/loading_widget.dart';
import 'package:school_management_app/app/common/style.dart';

class NoticeTile extends StatelessWidget {
  final String ?title;
  final String ?descrption;
  final String ?images;
  final String ?time;
  const NoticeTile({super.key,  this.descrption, this.images, this.title, this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                  blurRadius: 8, color: primaryColor, offset: Offset(2, 2))
            ]
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
                    placeholder: (context, url) => loadingWidget(
                      10.0
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ],
            ),
          
        ]),
      ),
    );
  }
}