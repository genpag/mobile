import 'package:mobile/domain/todo/todo.domain.service.dart';

class TodoDomainBinding {
  TodoDomainService _toToDomainService;

  TodoDomainBinding() {
    _toToDomainService = TodoDomainService();
  }

  TodoDomainService getDomainService() {
    return _toToDomainService;
  }
}
