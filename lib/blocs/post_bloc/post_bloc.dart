import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<SubmitButtonPressed>((event, emit) async {
      try {
        var url = Uri.parse(
            'http://103.120.178.195/Sang.Ray.Mob.Api/Ray/PostIncident');
        var headers = {
          'Content-Type': 'multipart/form-data',
        };

        var request = http.MultipartRequest("POST", url);
        request.headers.addAll(headers);

        if (event.path.isNotEmpty) {
          http.MultipartFile multipartFile =
              await http.MultipartFile.fromPath("name", event.path);
          request.files.add(multipartFile);
        }
        event.body.forEach((key, value) {
          request.fields[key] = value;
        });

        var response = await http.Response.fromStream(await request.send());

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
