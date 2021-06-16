import 'dart:async';
import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/tag.dart';
import '../../domain/entities/tag_list_response.dart';
import '../../domain/entities/tag_response.dart';
import '../../domain/repositories/tag_repository.dart';

part 'tag_event.dart';
part 'tag_state.dart';

class TagBloc extends Bloc<TagEvent, TagState> {
  final TagRepository tagRepository;

  TagBloc({@required this.tagRepository}) : super(TagInitial());

  @override
  Stream<TagState> mapEventToState(
    TagEvent event,
  ) async* {
    if (event is LoadTagsEvent) {
      yield TagsLoading();
      yield* _mapLoadTagsToState();
    } else if (event is LoadJobTagsEvent) {
      yield JobTagsLoading();
      yield* _mapLoadJobTagsToState(event.jobId);
    }
  }

  Stream<TagState> _mapLoadTagsToState() async* {
    try {
      TagListResponse response = await tagRepository.listTags();
      if (response == null) {
        yield LoadTagsFailed();
      } else {
        if (response.tags == null || response.tags.length == 0) {
          response.tags = Tag.defaultTags;
          var tagIterator = response.tags.iterator;
          while (tagIterator.moveNext()) {
            Tag tag = tagIterator.current;
            try {
              TagResponse tagResponse = await tagRepository.createTag(tag);
              if (tagResponse == null) {
              } else if (tagResponse != null &&
                  tagResponse.exception != null) {
              } else if (tagResponse.tag != null) {
              }
            } catch (e) {
              print(e.toString());
            }
          }
        }
        yield TagsLoaded(tags: response.tags);
      }
    } catch (e) {
      yield LoadTagsFailed();
    }
  }

  Stream<TagState> _mapLoadJobTagsToState(int jobId) async* {
    try {
      TagListResponse response = await tagRepository.listJobTags(jobId);
      if (response == null) {
        yield LoadJobTagsFailed();
      } else {
        yield JobTagsLoaded(tags: response.tags);
      }
    } catch (e) {
      yield LoadJobTagsFailed();
    }
  }
}
