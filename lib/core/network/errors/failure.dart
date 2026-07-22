abstract class Failure {
  final String msg;
  const Failure({required this.msg});
}

class ServerFailure extends Failure {
  const ServerFailure({required super.msg});
}

class DataMappingFailure extends Failure {
  const DataMappingFailure({required super.msg});
}