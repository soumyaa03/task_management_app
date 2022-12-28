import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:task_management_app/models/task_model.dart';
import 'package:task_management_app/services/api_constants.dart';

class ApiService {
  Future<List<TaskModel>?> getTasks() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<TaskModel> model = taskModelFromJson(response.body);
        log('we got the data');
        return model;
      } else {
        log('we did not got the data');
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<void> postData(Map<String, dynamic> body) async {
    try {
      var url = Uri.parse(ApiConstants.postUrl);

      var bodyEncoded = json.encode(body);
      log(body.toString());
      var response = await http.post(
        url,
        body: bodyEncoded,
      );

      if (response.statusCode == 200) {
        log('we posted the data');
        log(response.body.toString());
      } else {
        log('we could not the post the data');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> updateData(Map<String, dynamic> body, String api) async {
    try {
      var url = Uri.parse(ApiConstants.updateUrl + api);
      log(url.toString());
      var bodyEncoded = json.encode(body);
      log(body.toString());
      var response = await http.put(
        url,
        body: bodyEncoded,
      );

      if (response.statusCode == 200) {
        log('we updated the data');
        log(response.body.toString());
      } else {
        log('we could not the update the data');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> deleteData(String api) async {
    try {
      var url = Uri.parse(ApiConstants.deleteUrl + api);
      var response = await http.delete(
        url,
      );

      if (response.statusCode == 200) {
        log('we deleted the data');
        log(response.body.toString());
      } else {
        log('we could not the delete the data');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
