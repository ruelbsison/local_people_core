import 'dart:ui';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'tag.dart';
import 'location.dart';

class Job extends Object {
  int id;
  String title;
  String description;
  String preview;
  String budget;
  Location location;
  List<Tag> tags;
  List<String> images;
  int minutesLeft;
  int clientId;
  int traderId;
  DateTime date;
  bool private;

  Job({
    @required this.id,
    @required this.clientId,
    this.traderId,
    this.title,
    this.description,
    this.preview,
    this.location,
    this.budget,
    this.tags,
    this.minutesLeft,
    this.images,
    this.date,
    this.private = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) || this.hashCode == other.hashCode;

  @override
  int get hashCode => id;

  static empty() {
    return Job(id: 0,
        clientId: 0,
        traderId: 0,
        title: '',
        description: '',
        preview: '',
        location: Location.empty(),
        budget: '',
        tags: [],
        minutesLeft: 0,
        images: [],
        date: DateTime.now());
  }
}

List requestedJobs = [

];

List yourJobs = [

];

List demeJobs = [
  Job(
    id: 1,
    clientId: 1,
    title: 'Job request name or description',
    description: 'Short job description preview, job description preview, short job description preview, job description preview.',
    preview: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec finibus nulla vel iaculis aliquet. Integer lacus nibh, elementum id feugiat vel, hendrerit in metus. Donec interdum imperdiet sem eu facilisis. Duis eu sapien in elit eleifend dictum. Nunc at odio tempus lacus pretium fermentum.',
    location: Location.empty(),
    budget: 'PXXX',
    tags: [],
    minutesLeft: 120,
    images: [
      //File: '/Users/ruelsison/Library/Developer/CoreSimulator/Devices/72B25B60-50C1-4DBF-8D3B-4047745A5B09/data/Containers/Data/Application/157882FD-D41D-40DA-A414-98F227C42D69/tmp/image_picker_90D8C03A-41C4-42B6-9496-D3606D8690E0-12167-000006A1BD199B9F.jpg',
      //File: '/Users/ruelsison/Library/Developer/CoreSimulator/Devices/72B25B60-50C1-4DBF-8D3B-4047745A5B09/data/Containers/Data/Application/157882FD-D41D-40DA-A414-98F227C42D69/tmp/image_picker_049EEE4A-6936-46E0-89EE-D3B2EB14BB53-12167-000006A4BB5623DF.jpg',
      //File: '/Users/ruelsison/Library/Developer/CoreSimulator/Devices/72B25B60-50C1-4DBF-8D3B-4047745A5B09/data/Containers/Data/Application/157882FD-D41D-40DA-A414-98F227C42D69/tmp/image_picker_09C4C0A3-F344-4D43-91E6-8CD8936F7D03-12167-000006A7D2C2E957.jpg'
    ],
    date: DateTime.now(),
  ),
  Job(
    id: 2,
    clientId: 1,
    title: 'Job request name or description',
    description: 'Short job description preview, job description preview, short job description preview, job description preview.',
    preview: 'Short job description preview, job description preview, short job description preview, job description preview.',
    location: Location.empty(),
    budget: 'PXXX',
    tags: [],
    minutesLeft: 120,
    images: [],
    date: DateTime.now(),
  )
];
