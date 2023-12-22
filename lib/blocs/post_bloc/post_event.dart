part of 'post_bloc.dart';

@immutable
sealed class PostEvent {}

class SubmitButtonPressed extends PostEvent {
  Map body;
  String path;

  SubmitButtonPressed({required this.body, required this.path});

  @override
  List<Object> get props => [];
}
