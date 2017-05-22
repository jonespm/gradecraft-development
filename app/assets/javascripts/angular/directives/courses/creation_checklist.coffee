# Creates a checklist during course creation for Faculty to check off as they
# design the course.

@gradecraft.directive 'courseCreationChecklist', ['$q', 'CourseService', ($q, CourseService) ->
  CourseCreationController = [()->
    vm = this
    vm.loading = true
    vm.CourseService = CourseService

    services(vm.courseId).then(()->
      vm.loading = false
    )

    vm.inputId = (item)->
      "course_#{vm.courseId}-#{item.item}"

    vm.termFor = (term)->
      vm.CourseService.termFor(term)

    vm.checklistItems = ()->
      vm.CourseService.creationChecklist()

    vm.toggleChecklistItem = (item)->
      item.done = !item.done
      CourseService.updateCourseCreationItem(item)
  ]

  services = (courseId)->
    promises = [
      CourseService.getCourseCreation(courseId)
    ]
    return $q.all(promises)

  return {
    bindToController: true,
    controller: CourseCreationController,
    controllerAs: 'vm',
    templateUrl: 'courses/creation_checklist.html',
  }
]
