@gradecraft.directive 'assignmentsImportCsvReview',
  ['AssignmentTypeService', 'AssignmentImporterService', (AssignmentTypeService, AssignmentImporterService) ->
    AssignmentsImportCsvReviewCtrl = [()->
      vm = this
      vm.loading = true
      vm.submitted = false

      vm.assignmentTypes = AssignmentTypeService.assignmentTypes

      vm.newAssignmentTypes = () ->
        hasNewAssignmentTypes = _.filter(AssignmentImporterService.assignmentRows, (row) ->
          !row.has_matching_assignment_id is true and !row.selected_assignment_type? and
            row.assignment_type
        )
        return null if hasNewAssignmentTypes.length < 1
        _.uniq(_.pluck(hasNewAssignmentTypes, 'assignment_type'))

      vm.postImportAssignments = () ->
        vm.submitted = true
        AssignmentImporterService.postImportAssignments(@provider)

      AssignmentTypeService.getAssignmentTypes().finally(() ->
        vm.loading = false
      )
    ]

    {
      scope:
        provider: '@'
        cancelPath: '@'
      bindToController: true
      controllerAs: 'vm'
      controller: AssignmentsImportCsvReviewCtrl
      templateUrl: 'assignments/import/csv_review.html'
      link: (scope, elm, attrs) ->
        scope.assignmentRows = AssignmentImporterService.assignmentRows
        scope.results = AssignmentImporterService.results
    }
  ]
