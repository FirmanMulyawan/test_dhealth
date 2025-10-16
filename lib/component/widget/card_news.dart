import 'package:flutter/material.dart';

import '../config/app_style.dart';
import '../model/news_response.dart';
import 'expandible_text.dart';

class CardNews extends StatelessWidget {
  const CardNews({
    super.key,
    required this.isLoading,
    this.data,
  });

  final bool isLoading;
  final Articles? data;

  @override
  Widget build(BuildContext context) {
    final String defaultTitle =
        "Julio Rodriguez's three-run HR gives Mariners early ALCS Game 2 lead - ESPN";
    final String defaultDesc =
        "The home run marked the Seattle Mariners center fielder's second of the postseason.";
    final String defaultAuthor = "Anthony Gharib";
    final String defaultSourceName = "Investor's Business Daily";

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(maxHeight: 150),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
          ),
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(
              isLoading == true ? '' : data?.urlToImage ?? '',
              fit: BoxFit.fitWidth,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  height: 180,
                  child: Center(
                    child: isLoading == false
                        ? Icon(
                            Icons.broken_image,
                            color: Colors.grey,
                            size: 50,
                          )
                        : Container(),
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: Icon(
                    Icons.circle,
                    size: 8,
                    color: AppStyle.greyDark,
                  ),
                ),
                Expanded(
                  child: Text(
                      isLoading == false
                          ? data?.source?.name ?? ''
                          : defaultSourceName,
                      style: AppStyle.regular(
                          size: 14, textColor: AppStyle.greyDark)),
                ),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            data?.author != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 4),
                        child: Icon(
                          Icons.circle,
                          size: 8,
                          color: AppStyle.greyDark,
                        ),
                      ),
                      Expanded(
                        child: Text(
                            isLoading == false
                                ? data?.author ?? ''
                                : defaultAuthor,
                            style: AppStyle.regular(
                                size: 14, textColor: AppStyle.greyDark)),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Text(isLoading == false ? data?.title ?? '' : defaultTitle,
            style: AppStyle.medium(size: 18, textColor: AppStyle.black)),
        SizedBox(
          height: 5,
        ),
        ExpandableText(
          text: isLoading == false ? data?.description ?? '' : defaultDesc,
          maxLines: 4,
          style: AppStyle.regular(size: 14, textColor: AppStyle.black),
        )
      ],
    );
  }
}
