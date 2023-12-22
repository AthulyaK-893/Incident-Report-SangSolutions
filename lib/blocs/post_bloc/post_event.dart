part of 'post_bloc.dart';

@immutable
sealed class PostEvent {}
class SubmitButtonPressed extends PostEvent {
 
  SubmitButtonPressed();

  @override
  List<Object> get props => [];
}
