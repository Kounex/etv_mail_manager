import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../utils/dio.dart';
import 'etv_mail.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: '/etv-mails')
abstract class ETVMailRestClient {
  factory ETVMailRestClient() => _ETVMailRestClient(DioClient.instance);

  @GET('')
  Future<List<ETVMail>> getAll();

  @GET('{uuid}')
  Future<ETVMail> get(@Path('uuid') String uuid);

  @POST('')
  Future<ETVMail> create(@Body() ETVMail mail);

  @PUT('{uuid}')
  Future<ETVMail> update(@Path() String uuid, @Body() ETVMail mail);

  @DELETE('{uuid}')
  Future<void> delete(@Path() String uuid);
}
