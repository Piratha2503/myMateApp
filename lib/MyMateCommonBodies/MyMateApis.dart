
import 'package:flutter/material.dart';

class MyMateAPIs{

  static String commonEndPoint = "/mymate/api/v1";
  static String vpsApi = "https://backend.graycorp.io:9000";
  static String localApi = "http://192.168.1.55:9000";

  static String mobile_number_registration_API = "$localApi$commonEndPoint/saveClientMobile";

  static String get_clientList_API = "$vpsApi$commonEndPoint/getClientDataList";

  static String get_client_byDocId_API = "$vpsApi$commonEndPoint/getClientDataByDocId";

  static String get_client_by_mobile = "$vpsApi$commonEndPoint/getClientDataByMobile";

  static String update_client_API = "$localApi$commonEndPoint/updateClient";

  static String save_client_API = "$localApi$commonEndPoint/saveClientData";

}