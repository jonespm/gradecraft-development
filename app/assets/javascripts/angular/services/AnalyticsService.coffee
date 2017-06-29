@gradecraft.factory 'AnalyticsService', ['$http', 'GradeCraftAPI', ($http, GradeCraftAPI) ->

  # We could add an indication if this has already loaded, or is loading,
  # to limit it to one call to the API, and put the directives in waiting pattern.
  # For simplicity sake, each graph on the analytics page initiating the api call.
  assignmentData = {}
  courseData = {}
  studentData = {}
  weeklyData = {}

  termFor = (article)->
    GradeCraftAPI.termFor(article)

  getAssignmentAnalytics = (assignmentId, studentId)->
    $http.get("/api/assignments/#{assignmentId}/analytics?student_id=#{studentId}").then(
      (response) ->
        angular.copy(response.data, assignmentData)
        GradeCraftAPI.logResponse(response.data)
      ,(response) ->
        GradeCraftAPI.logResponse(response)
    )

  getCourseAnalytics = ()->
    $http.get("/api/courses/analytics").then(
      (response) ->
        angular.copy(response.data, courseData)
        GradeCraftAPI.logResponse(response.data)
      ,(response) ->
        GradeCraftAPI.logResponse(response)
    )

  getStudentAnalytics = (studentId)->
    if studentId
      url = "/api/students/#{studentId}/analytics"
    else
      url = "/api/students/analytics"

    $http.get(url).then(
      (response) ->
        angular.copy(response.data, studentData)
        GradeCraftAPI.logResponse(response.data)
      ,(response) ->
        GradeCraftAPI.logResponse(response)
    )

  getWeeklyAnalytics = (studentId)->
    if studentId
      url = "/api/courses/one_week_analytics?student_id=#{studentId}"
    else
      url = "/api/courses/one_week_analytics"

    $http.get(url).then(
      (response) ->
        angular.copy(response.data, weeklyData)
        GradeCraftAPI.logResponse(response.data)
      ,(response) ->
        GradeCraftAPI.logResponse(response)
    )


  return {
    termFor: termFor
    getAssignmentAnalytics: getAssignmentAnalytics
    getStudentAnalytics: getStudentAnalytics
    getCourseAnalytics: getCourseAnalytics
    getWeeklyAnalytics: getWeeklyAnalytics
    assignmentData: assignmentData
    courseData: courseData
    studentData: studentData
    weeklyData: weeklyData
  }
]
