import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:smart_news/Models/NewsModel.dart';

import 'Images.dart';
import 'constant.dart';

Widget placeHolderWidget(
{
    double? height,
    double? width,
    BoxFit? fit,
    AlignmentGeometry? alignment,
    double? radius
  }
) 
{
return Image.asset(greyImage,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
        alignment: alignment ?? Alignment.center)
    .cornerRadiusWithClipRRect(radius ?? defaultRadius);
}

Widget cachedImage(String url,
    {double? height,
    double? width,
    BoxFit? fit,
    AlignmentGeometry? alignment,
    bool usePlaceholderIfUrlEmpty = true,
    double? radius}) {
  if (url.validate().isEmpty) {
    return placeHolderWidget(
        height: height,
        width: width,
        fit: fit,
        alignment: alignment,
        radius: radius);
  } else if (url.validate().startsWith('http')) {
    return CachedNetworkImage(
      imageUrl: url,
      height: height,
      width: width,
      fit: fit,
      alignment: alignment as Alignment? ?? Alignment.center,
      errorWidget: (_, s, d) {
        return placeHolderWidget(
            height: height,
            width: width,
            fit: fit,
            alignment: alignment,
            radius: radius);
      },
      placeholder: (_, s) {
        if (!usePlaceholderIfUrlEmpty) return SizedBox();
        return placeHolderWidget(
            height: height,
            width: width,
            fit: fit,
            alignment: alignment,
            radius: radius);
      },
    );
  } else {
    return Image.asset(url,
            height: height,
            width: width,
            fit: fit,
            alignment: alignment ?? Alignment.center)
        .cornerRadiusWithClipRRect(radius ?? defaultRadius);
  }
}

// ??????????????? ListView ??????????????????????????????????????????
Widget listViewNews(List<NewsModel> news) { //????????? parameter ???????????? Model List ????????????????????????????????? news ?????????
  return ListView.builder(
    //ListView builder ??????????????????????????? popperty ???????????? itemBuilder ?????????????????????????????? Widget ???????????????????????? Widget ListView.builder , itemCount ?????????????????????????????????????????????????????????????????? ???????????????????????????
    itemCount: news.length, //??????????????????????????????????????????????????????????????????
    shrinkWrap: true, //wrap ??????????????????????????? listView ?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
    physics: NeverScrollableScrollPhysics(),//???????????????????????????????????????????????? ??? ????????????????????? ???????????? ???????????? content ????????? ??? ??????????????????????????????????????????????????????????????????????????????????????????????????????????????? NeverScrollableScrollPhysics ????????? ?????????????????????????????????????????????????????????????????????????????????????????????????????? shrinkWrap
    padding: EdgeInsets.all(8), //????????????????????????????????? listview
    scrollDirection: Axis.vertical, //??????????????????????????????????????????????????? vertical ????????????????????? , horizontal ??????????????????
    itemBuilder: (context,index) { //ListView.builder ???????????? index ????????????????????????????????????????????????

      //Load Model news ????????????????????????????????? Object newsModel
      NewsModel newsModel = news[index]; //news ???????????????????????????????????? parameter ?????????????????????????????? Model ????????????????????? list array ?????????????????????????????? index ????????????????????????????????????????????????????????????????????? index array
      // inspect(newsModel);
      return  GestureDetector( // ????????????????????????????????????????????? a href
                onTap: () {
                  Navigator.pushNamed(context, '/newsdetail', arguments: { 'id': newsModel.id }); //?????????????????????????????????????????????????????????????????? id ??????
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  width: context.width(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Hero( //widget hero ????????? animations ????????????????????????????????????????????? Modal ????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????? tag ?????????????????????????????????
                        tag: newsModel.id!, //???????????????????????? tag ???????????????????????? id ??????????????? ?????????????????????????????? tag ????????????????????? ! ????????????????????????????????? null
                        child: cachedImage( //????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
                                newsModel.embedded!.wpFeaturedmedia![0].sourceUrl.toString(), //?????????????????????????????????????????????
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover)
                            .cornerRadiusWithClipRRect(10)
                            .visible( //??????????????????????????????????????????????????????????????????????????????
                                newsModel.embedded!.wpFeaturedmedia![0].sourceUrl.toString().isNotEmpty, //??????????????????????????????????????????????????????????????????????????????????????????
                                defaultWidget: Image.asset(greyImage, //??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
                                fit: BoxFit.cover,
                                height: 150,
                                width: 150)
                                .cornerRadiusWithClipRRect(10)
                            ),
                      ),
                      8.width,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              parseHtmlString( newsModel.title!.rendered ), //?????????????????????????????????????????????????????????????????????
                              style: boldTextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .color,
                                  size: textSizeMedium),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            8.height,
                            Text(
                              parseHtmlString( newsModel.content!.rendered ),  //????????????????????????????????????????????????????????????????????????
                              style:
                                  secondaryTextStyle(size: textSizeSMedium),
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                            ),
                            8.height,
                            Align(
                              child: Text(
                                  DateFormat.yMMMMd('en_US').format(
                                      DateTime.parse( newsModel.dateGmt.toString() )), //???????????????????????????????????????????????? packet ????????? format date
                                  style: secondaryTextStyle(size: 11)),
                              alignment: Alignment.centerRight,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
    },
  );
  
}

String parseHtmlString(String? htmlString) { //function ???????????? html to string
  return parse(parse(htmlString).body!.text).documentElement!.text;
}