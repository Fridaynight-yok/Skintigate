import 'package:get_storage/get_storage.dart';

class Storage {
  final appStorage = GetStorage();
  //user_key คือ uid
  String userKey = "user_key";

  ///จำ uid ของ users ไว้ในเครื่อง [login]
  void setUserId(String uid) {
    appStorage.write(userKey, uid);
  }

  ///ลบ uid ของ users ในเครื่อง [logout]
  void removeUserId() {
    appStorage.remove(userKey);
  }

  ///เข้าถึง uid ที่จำไว้ในเครื่อง [profile]
  String? getUserId() {
    return appStorage.read(userKey);
  }

  ///ตรวจสอบว่ามี uidในเครื่องรึยัง
  bool isLogin() {
    return (getUserId() ?? '').isNotEmpty;
  }
}
