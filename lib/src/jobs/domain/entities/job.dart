import 'dart:ui';
import 'package:meta/meta.dart';

class Job extends Object {
  int id;
  String title;
  String description;
  String preview;
  String budget;
  String location;
  List<String> tags;
  List<String> images;
  int minutesLeft;
  int client_id;
  DateTime date;

  Job({
    @required this.id,
    @required this.client_id,
    this.title,
    this.description,
    this.preview,
    this.location,
    this.budget,
    this.tags,
    this.minutesLeft,
    this.images,
    this.date,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) || this.hashCode == other.hashCode;

  @override
  int get hashCode => id;

  static empty() {
    return Job(id: 0,
        client_id: 0,
        title: '',
        description: '',
        preview: '',
        location: '',
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
    client_id: 1,
    title: 'Job request name or description',
    description: 'Short job description preview, job description preview, short job description preview, job description preview.',
    preview: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec finibus nulla vel iaculis aliquet. Integer lacus nibh, elementum id feugiat vel, hendrerit in metus. Donec interdum imperdiet sem eu facilisis. Duis eu sapien in elit eleifend dictum. Nunc at odio tempus lacus pretium fermentum.',
    location: 'Cumberland & Grange',
    budget: 'PXXX',
    tags: ['Tag Numero Uno', 'Tag Numero Dos'],
    minutesLeft: 120,
    images: [],
    date: DateTime.now(),
  ),
  Job(
    id: 2,
    client_id: 1,
    title: 'Job request name or description',
    description: 'Short job description preview, job description preview, short job description preview, job description preview.',
    preview: 'Short job description preview, job description preview, short job description preview, job description preview.',
    location: 'Cumberland & Grange',
    budget: 'PXXX',
    tags: [
      'Tag Numero 01',
      'Tag Numero Eleventy',
      'Tag Numero Eleventy',
      'Tag Numero Eleventy',
      'Tag Numero Eleventy'
    ],
    minutesLeft: 120,
    images: [],
    date: DateTime.now(),
  )
];
