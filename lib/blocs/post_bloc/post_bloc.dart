import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<SubmitButtonPressed>((event, emit) async {
      try {
        final response = await http.post(
          Uri.parse('http://103.120.178.195/Sang.Ray.Mob.Api/Ray/PostIncident'),
          body: {
           
          },
        );
        log(response.body.toString());

        if (response.statusCode == 200) {
        } else {
          final errorMessage = response.body;

          emit(CreateFailure(error: errorMessage));
        }
      } catch (error) {
        log('Error: $error');

        emit(CreateFailure(error: error.toString()));
      }
    });
  }
}
