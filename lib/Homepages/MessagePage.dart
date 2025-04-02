import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'message_service.dart';

class MessagePage extends StatefulWidget {
  final String soulId;
  final String docId;
  const MessagePage({super.key, required this.soulId,required this.docId});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  TextEditingController _messageController = TextEditingController();

  @override
  void initState(){
    super.initState();
    MessageService.updateMessageStatus(widget.soulId, widget.docId, "seen");
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      MessageService.sendMessage(widget.docId, widget.soulId, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: MyMateThemes.primaryColor,
        title: Text("Chat"),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: SvgPicture.asset('assets/images/chevron-left.svg', width: 24),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: MessageService.getMessages(widget.docId, widget.soulId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                final messages = snapshot.data!;

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    bool isMe = message['senderId'] == widget.docId;

                    return Align(
                      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isMe ? Colors.blue : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              message['message'],
                              style: TextStyle(color: isMe ? Colors.white : Colors.black),
                            ),
                            SizedBox(height: 5),
                            if (isMe)
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    message['status'] == 'sent'
                                        ? Icons.check
                                        : message['status'] == 'delivered'
                                        ? Icons.done_all
                                        : Icons.done_all,
                                    color: message['status'] == 'seen' ? Colors.blue : Colors.grey,
                                    size: 16,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    message['status'].toUpperCase(),
                                    style: TextStyle(fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: "Type a message...",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
          SizedBox(width: 10),
          IconButton(
            icon: Icon(Icons.send, color: MyMateThemes.primaryColor),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}
