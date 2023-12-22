part of 'post_bloc.dart';

@immutable
sealed class PostState {}

final class PostInitial extends PostState {}
class CreateLoading extends PostState {}

class CreateSuccess extends PostState {
 

}

class CreateFailure extends PostState {
  final String error;

  CreateFailure({required this.error});

  @override
  List<Object> get props => [error];
}