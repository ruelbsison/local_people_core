import 'package:local_people_core/jobs.dart';
import 'tags_test_data.dart';
import 'locations_test_data.dart';

List<Job> testJobs = [
  Job(
    id: 0,
    clientId: 1,
    title: 'Job request name or description',
    description: 'Short job description preview, job description preview, short job description preview, job description preview.',
    preview: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec finibus nulla vel iaculis aliquet. Integer lacus nibh, elementum id feugiat vel, hendrerit in metus. Donec interdum imperdiet sem eu facilisis. Duis eu sapien in elit eleifend dictum. Nunc at odio tempus lacus pretium fermentum.',
    budget: '500',
    tags: testTags,
    images: [],
    minutesLeft: 120,
    date: DateTime.now(),
  ),
  Job (
    id: 0,
    clientId: 2,
    title: 'Job request name or description',
    description: 'Short job description preview, job description preview, short job description preview, job description preview.',
    preview: 'Short job description preview, job description preview, short job description preview, job description preview.',
    budget: '1,000',
    tags: testTags,
    minutesLeft: 120,
    images: [],
    date: DateTime.now(),
  ),
  Job (
    id: 0,
    clientId: 1,
    title: 'Job request name or description',
    description: 'Short job description preview, job description preview, short job description preview, job description preview.',
    preview: 'Short job description preview, job description preview, short job description preview, job description preview.',
    budget: '2,000',
    tags: testTags,
    minutesLeft: 120,
    images: [],
    date: DateTime.now(),
  ),
  Job (
    id: 0,
    clientId: 2,
    title: 'Job request name or description',
    description: 'Short job description preview, job description preview, short job description preview, job description preview.',
    preview: 'Short job description preview, job description preview, short job description preview, job description preview.',
    budget: '3,000',
    tags: testTags,
    minutesLeft: 120,
    images: [],
    date: DateTime.now(),
  )
];