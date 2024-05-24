import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:tourease/constants/assets_constant.dart';

class AiChatbotController extends GetxController {
  RxList<ChatMessage> messages = RxList<ChatMessage>();

  AiChatbotController() {
    messages.add(
      ChatMessage(
        text: 'Hai saya travel assistant mu!👋\nBagaimana saya dapat membantu?',
        user: ChatUser(
            id: '1',
            firstName: 'AI',
            profileImage: AssetsCollection.chatbotIcon),
        createdAt: DateTime.now(),
      ),
    );
  }

  void sendMessage(ChatMessage m, ChatUser aiUser) {
    final gemini = Gemini.instance;

    messages.insert(0, m);
    try {
      // variable tampungan dari object chatMessage
      String question = m.text;

      gemini
          .streamGenerateContent(
        question,
      )
          .listen(
        (event) {
          ChatMessage? lastMessage = messages.firstOrNull;

          if (lastMessage != null && lastMessage.user == aiUser) {
            lastMessage = messages.removeAt(0);
            String response = event.content?.parts?.fold(
                  "",
                  (previousValue, element) => "$previousValue${element.text}",
                ) ??
                "";
            response = response.replaceAll('*', '');

            lastMessage.text += response;

            messages.insert(0, lastMessage);
          } else {
            String response = event.content?.parts?.fold(
                  "",
                  (previousValue, element) => "$previousValue${element.text}",
                ) ??
                "";

            response = response.replaceAll('*', '');

            ChatMessage message = ChatMessage(
              user: aiUser,
              createdAt: DateTime.now(),
              text: response,
            );

            messages.insert(0, message);
          }
        },
      );
    } catch (e) {
      throw e.toString();
    }
  }
}
