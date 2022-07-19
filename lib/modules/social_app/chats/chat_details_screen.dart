import 'package:firstgp/globals/globalVariables.dart';
import 'package:firstgp/layout/social_app/cubit/cubit.dart';
import 'package:firstgp/layout/social_app/cubit/states.dart';
import 'package:firstgp/models/social_app/chat_model.dart';

import 'package:firstgp/shared/components/constants.dart';
import 'package:firstgp/shared/styles/icon_broken.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetailsScreen extends StatelessWidget {
  String receiver, name, image;
  ChatDetailsScreen(
      {Key? key,
      required this.receiver,
      required this.name,
      required this.image})
      : super(key: key);

  var messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        if (receiver == "community") {
          SocialCubit.get(context).getCommunityMessages();
        } else if (receiver == "chatbot") {
          SocialCubit.get(context).getMessages(receiverId: receiver);
        } else {
          SocialCubit.get(context).getMessages(receiverId: receiver);
        }
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            int ItemCount;
            if (receiver == "community") {
              ItemCount = SocialCubit.get(context).communityMessages.length;
            } else if (receiver == "chatbot") {
              ItemCount = SocialCubit.get(context).messages.length;
            } else {
              ItemCount = SocialCubit.get(context).messages.length;
            }
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(children: [
                  CircleAvatar(
                    radius: 20.0,
                  backgroundColor: Colors.green[100],
                    backgroundImage: NetworkImage(
                      image,
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                      height: 1.4,
                    ),
                  ),
                ]),
              ),
              body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var message;
                            if (receiver == "community") {
                              message = SocialCubit.get(context)
                                  .communityMessages[index];
                            } else if (receiver == "chatbot") {
                              message =
                                  SocialCubit.get(context).messages[index];
                            } else {
                              message =
                                  SocialCubit.get(context).messages[index];
                            }
                            if (uId == message.senderId) {
                              return buildMyMessage(message);
                            } else {
                              return receiver == "community"
                                  ? buildCommunityMessage(message)
                                  : buildMessage(message);
                            }
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 10.0,
                              ),
                          itemCount: ItemCount),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: messageController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Type your message here ...'),
                            ),
                          ),
                          Container(
                            height: 50.0,
                            color: Colors.green[500],
                            child: MaterialButton(
                              onPressed: () {
                                if (receiver == "community") {
                                  SocialCubit.get(context).sendMessageTogroup(
                                      dateTime: DateTime.now().toString(),
                                      text: messageController.text);
                                  messageController.text = '';
                                } else if (receiver == "chatbot") {
                                  // to do
                                  SocialCubit.get(context).sendMessageToChatbot(
                                      dateTime: DateTime.now().toString(),
                                      text: messageController.text);
                                  messageController.text = '';
                                } else {
                                  SocialCubit.get(context).sendMessage(
                                      receiverId: receiver,
                                      dateTime: DateTime.now().toString(),
                                      text: messageController.text);
                                  messageController.text = '';
                                }
                              },
                              minWidth: 1.0,
                              child: const Icon(
                                IconBroken.Send,
                                size: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildCommunityMessage(MessageModel message) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Row(
          children: [
            CircleAvatar(
              radius: 20.0,
            backgroundColor: Colors.green[100],
              backgroundImage: NetworkImage(message.imageOfSender),
            ),
            const SizedBox(
              width: 15.0,
            ),
            Flexible(
                child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(10.0),
                  topEnd: Radius.circular(10.0),
                  topStart: Radius.circular(10.0),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              child: Text(
                message.text,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                //  softWrap: false,
              ),
            )),
          ],
        ),
      );
  Widget buildMessage(MessageModel message) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Row(
          children: [
            Flexible(
                child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(10.0),
                  topEnd: Radius.circular(10.0),
                  topStart: Radius.circular(10.0),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              child: Text(
                message.text,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                //  softWrap: false,
              ),
            )),
          ],
        ),
      );
  Widget buildMyMessage(MessageModel message) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Flexible(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: const BorderRadiusDirectional.only(
                bottomStart: Radius.circular(10.0),
                topEnd: Radius.circular(10.0),
                topStart: Radius.circular(10.0),
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            child: Text(
              message.text,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      );
}
