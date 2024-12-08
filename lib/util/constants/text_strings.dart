class CTextStrings {
  CTextStrings._();
  //Authentication message
  static const String title = "Welcome back,";
  static const String subTitle = "Ready to achieve more? Let's dive in.";
  static const String loginSuccess = "Logged in successfully";

  //Authentication Form Text
  static const String email = "Email";
  static const String password = "Password";
  static const String signIn = "Sign In";

  //Authentiaction errors
  static const String noEmail = "Please enter email";
  static const String errorEmail = "Invalid email format";
  static const String errorPassword = "Enter a strong password";
  static const String noPassword = "Please enter a password";

  //Task errors
  static const String enterTitleName = 'Please enter a task name';
  static const String enterDescription = "Please enter a description";
  static const String selectDueDate = "Please select a valid date";
  static const String caanotEditStatusAtTheTimeOfCreation =
      "Status can be edited after task is added";
  //static const String status = "Please select a task status";

  //Task Page
  static const String taskTitle = "Task Title";
  static const String taskDescription = "Task Description";
  static const String completionDate = "Completion Date";
  static const String taskStatus = "Task Status";
  static const String addTask = "Add Task";
  static const String taskQuote =
      "The secret to getting ahead is getting started.";

  static const String dueDate = "Due Date";

  //Home Page
  static const String greetings = "Good Day for Doing Your Tasks";
  static const String noTaskAvailable = "No tasks available";
  static const String homePageQuote =
      "Organize, Prioritize, Achieve – Your Tasks, Your Way.";
  static const String noTaskInThisCategory = "No tasks in this category.";

  //Profile Page
  static const String logOut = "Logout";

  //Update Task
  static const String statusUpdatedSuccessfully = "Status Updated Successfully";
  static const String problemOccuredWhileUpdatingTheTask =
      "Problem occured while updating the task";
  static const String invalidStatusTransition = "Invalid status transition!";
  static const String statusUpdated = "Status Updated";

  //UserDetails Error
  static const String emailNotFound = "Email Id not found";
  static const String userIdError = "User id not found";
}
