import 'dart:async';

abstract class MessageRepository {

  MessageRepository();

  Future<List> loadAllMessages();

  Future<bool> sendMessage({String message});

}