import 'package:tajwid/app/constants/http_codes.dart';

class HttpException implements Exception {
  final int code;
  final String prefix;

  const HttpException(this.prefix, this.code);
}

class UnknownException extends HttpException {
  UnknownException(this.message)
    : super("UnknownException", HttpCodes.BadRequest);
  final String message;

  @override
  String toString() => message;
}

class BadRequestException extends HttpException {
  BadRequestException(this.message)
    : super("BadRequestException", HttpCodes.BadRequest);
  final String message;
  @override
  String toString() => message;
}

class UnauthorizedException extends HttpException {
  UnauthorizedException(this.message)
    : super("UnauthorizedException", HttpCodes.BadRequest);
  final String message;
  @override
  String toString() => message;
}

class ForbiddenException extends HttpException {
  const ForbiddenException(this.message)
    : super("ForbiddenException", HttpCodes.Forbidden);
  final String message;
  @override
  String toString() => message;
}

class NotFoundException extends HttpException {
  const NotFoundException(this.message)
    : super("NotFoundException", HttpCodes.NotFound);
  final String message;
  @override
  String toString() => message;
}

class MethodNotAllowedException extends HttpException {
  const MethodNotAllowedException(this.message)
    : super("MethodNotAllowedException", HttpCodes.MethodNotAllowed);
  final String message;
  @override
  String toString() => message;
}

class RequestTimeoutException extends HttpException {
  const RequestTimeoutException(this.message)
    : super("RequestTimeoutException", HttpCodes.RequestTimeout);
  final String message;
  @override
  String toString() => message;
}

class InternalServerErrorException extends HttpException {
  const InternalServerErrorException(this.message)
    : super("InternalServerError", HttpCodes.InternalServerError);
  final String message;
  @override
  String toString() => message;
}

class ServiceUnavailableException extends HttpException {
  const ServiceUnavailableException(this.message)
    : super("ServiceUnavailable", HttpCodes.ServiceUnavailable);
  final String message;
  @override
  String toString() => message;
}

class GatewayTimeoutException extends HttpException {
  const GatewayTimeoutException(this.message)
    : super("GatewayTimeoutException", HttpCodes.GatewayTimeout);
  final String message;
  @override
  String toString() => message;
}
