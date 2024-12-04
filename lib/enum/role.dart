enum Role { unKnown, student, teacher }

String enumToString(Role role) {
  return role.toString().split('.').last;
}

Role stringToEnum(String roleString) {
  return Role.values
      .firstWhere((e) => e.toString().split('.').last == roleString);
}
