import 'package:fpdart/fpdart.dart';
import 'package:reditt_clone/core/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
