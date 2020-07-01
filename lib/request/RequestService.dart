import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:noticetracker/request/RequestResponse.dart';
import 'package:noticetracker/sharedPref/SharedPreferenceService.dart';

import 'Request.dart';
import 'RequestDto.dart';

class RequestService {
  static final String getUserRequestEndpoint = "/api/v1/requests/user?id=";
  static final String baseUrl = "https://pa2020-api.herokuapp.com";
  static final String sendRequestEndpoint = "/api/v1/requests/send";

  static Future<http.Response> _sendRequest(RequestDto request) async {
    String token = await SharedPreferenceService.getToken();
    int id = await SharedPreferenceService.getId();

    var body=jsonEncode(<String, Object>{
      "created_time": request.createdAt.toIso8601String(),
      "sentence": request.sentence,
      "state": "INIT",
      "user":{
        "user_id": id
      }
    });
    print("Body : $body");
    return http.post(baseUrl + sendRequestEndpoint,
        body: body,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer " + token,
        });
  }

  static Future<http.Response> _getPersonalRequest() async {
    String token = await SharedPreferenceService.getToken();
    int id = await SharedPreferenceService.getId();
    return http.get(baseUrl + getUserRequestEndpoint + "$id",
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer " + token,
        });
  }

  static RequestDto createRequest(String sentence) {
    return new RequestDto(new DateTime.now(), sentence);
  }

  static Future<RequestResponse> sendRequest(String sentence) async {
    RequestDto req = createRequest(sentence);
    var response = await _sendRequest(req);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Request send");
      RequestResponse requestResponse =
          _parseResponseForRequestResponse(jsonDecode(response.body));
      return requestResponse;
    } else {
      Fluttertoast.showToast(msg: " Error while sending the Request !");
      throw new Exception("Can't save request");
    }
  }

  static RequestResponse _parseResponseForRequestResponse(jsonDecode) {
    return RequestResponse(
        jsonDecode["positive"],
        jsonDecode["negative"],
        jsonDecode["neutral"],
        jsonDecode["total"],
        jsonDecode["word"],
        jsonDecode["request_id"]);
  }

  static Future<List<Request>> getRequest() async {
    var response = await _getPersonalRequest();
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var reqListJson = jsonBody as List;
      List<Request> requestResponse = _parseRequestList(reqListJson);
      return sortAndFilterList(requestResponse);
    } else {
      Fluttertoast.showToast(msg: " Error while sending the Request !");
      throw new Exception("Can't save request");
    }
  }

  static List<Request> _parseRequestList(List<dynamic> jsonList) {
    List<Request> list = new List<Request>();
    jsonList.forEach((req) {
      try {
        list.add(Request.withJson(req));
      } on ArgumentError catch (e) {
        print("Error : $e");
      }
    });
    return list;
  }
  
  static List<Request> sortAndFilterList(List<Request> list){
    list.sort((Request a, Request b) =>
      a.createTime.isAfter(b.createTime) == true ? -1 : 1
    );
    List<Request> l = list.where((req)=>req.analyzedRequest!=null && !req.analyzedRequest.hasNullElement()).toList();
    return l;
  }
}
