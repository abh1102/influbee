import 'package:get/get.dart';
import '../../controller/chat_contoller.dart';


class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(() => ChatController());
  }
}
