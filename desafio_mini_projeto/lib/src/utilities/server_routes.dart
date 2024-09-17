class ServerRoutes {
  static const signup = 'http://127.0.0.1:10100/sign_up_user';
  static const login = 'http://127.0.0.1:10100/login';
  static const addtask = 'http://127.0.0.1:10100/add_task';
  static const gettasks = 'http://127.0.0.1:10100/get_tasks';
  static const deletetask = 'http://127.0.0.1:10100/remove_task_by_id';
  static const edittask = ''; //ajustar
  //Eventos
  static const updaterequest = 'http://127.0.0.1:10100/counter/update_request';
  static const updateresponse =
      'http://127.0.0.1:10100/counter/update_response';
}
