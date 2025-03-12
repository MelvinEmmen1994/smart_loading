import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, String>> messages = [];
  final TextEditingController messageController = TextEditingController();

  final Map<String, String> faqResponses = {
    "Hallo": "Hallo! Hoe kan ik je helpen?",
    "Welke containers zijn beschikbaar?": "We ondersteunen 20ft, 40ft en 40ft high cube containers.",
    "Hoe exporteer ik naar Excel?": "Ga naar de exportpagina en selecteer 'Exporteren naar Excel'.",
    "Kan ik handmatig pallets verplaatsen?": "Ja, je kunt de configuratie handmatig aanpassen in de 3D-weergave.",
    "Synchronisatiecode gebruiken?": "Voer de code in bij 'Synchroniseren' en je configuratie wordt geladen.",
    "Dank je": "Graag gedaan!"
  };

  void sendMessage() {
    String userMessage = messageController.text.trim();
    if (userMessage.isNotEmpty) {
      setState(() {
        messages.add({"sender": "Gebruiker", "text": userMessage});
      });

      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          messages.add({"sender": "Chatbot", "text": faqResponses[userMessage] ?? "Sorry, dat begrijp ik niet."});
        });
      });

      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Live Chat")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Align(
                  alignment: message["sender"] == "Gebruiker" ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: message["sender"] == "Gebruiker" ? Colors.blue[200] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(message["text"] ?? ""),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(hintText: "Typ een bericht..."),
                  ),
                ),
                IconButton(onPressed: sendMessage, icon: const Icon(Icons.send)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
