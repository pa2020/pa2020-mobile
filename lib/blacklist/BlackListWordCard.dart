
import 'package:flutter/material.dart';
import 'package:noticetracker/blacklist/BlackListService.dart';
import 'package:noticetracker/util/AlertDialogDesign.dart';

import 'BlackList.dart';

class BlackListWordCard{

  static Widget blackListWordTemplate(BlackListWord word, BuildContext context) {
    return _generateWidgetCard(word, context);
  }

  static Widget _generateWidgetCard(BlackListWord word, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.blue)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5),
            child: Text(word.sentence,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 17,
              ),
              maxLines: 2,
            ),
          ),
          Container(
            child: RawMaterialButton(
              onPressed: (){
                Future deleteWordFuture=BlackListService.deleteBlackListWord(word.id);
                showDialog(context: context,
                    builder: (BuildContext context){
                      return AlertDialogDesign.futureAlertDialog(context, "Deleting a word to the black list", deleteWordFuture);
                    }
                );
              },
              elevation: 2.0,
              fillColor: Colors.red,
              child:
              Icon(Icons.remove,
                  color: Colors.white),
              padding: EdgeInsets.all(10.0),
              shape: CircleBorder(),
            ),
          ),
        ],
      ),
    );
  }
}