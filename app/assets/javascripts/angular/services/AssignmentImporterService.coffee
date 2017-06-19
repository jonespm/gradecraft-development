@gradecraft.factory 'AssignmentImporterService', ['$http', 'GradeCraftAPI', ($http, GradeCraftAPI) ->

  assignmentRows = []

  postUpload = (importer_provider_id, formData) ->
    $http.post("/api/assignments/importers/#{importer_provider_id}/upload",
      formData, {
        transformRequest: angular.identity,
        headers: { 'Content-Type': undefined }
      }
    ).then(
      (response) ->
        GradeCraftAPI.loadMany(assignmentRows, response.data)
        _parseDatesAsJavascript()
        GradeCraftAPI.logResponse(response.data)
      ,(response) ->
        GradeCraftAPI.logResponse(response)
    )

  postImportAssignments = (importer_provider_id) ->
    debugger
    console.log "We're debugging"

  # Converts a Ruby time as number of floating point seconds to a Javascript Time
  _parseDatesAsJavascript = () ->
    _.each(assignmentRows, (row) ->
      row.selectedDueDate = new Date(row.formatted_due_date)
    )

  {
    assignmentRows: assignmentRows
    postUpload: postUpload
    postImportAssignments: postImportAssignments
  }
]
