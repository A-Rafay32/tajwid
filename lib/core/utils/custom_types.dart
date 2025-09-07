import 'package:either_dart/either.dart';
import 'package:tajwid/core/exceptions/exceptions.dart';

typedef FutureEither0 = Future<Either<Failure, Success>>;
typedef FutureEither1<T> = Future<Either<Failure, T>>;
typedef Either0 = Either<Failure, Success>;
typedef Either1<T> = Either<Failure, T>;
